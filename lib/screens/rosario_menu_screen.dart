import 'package:flutter/material.dart';
import '../models/rosario_model.dart';
import '../services/rosario_service.dart';
import 'rosario_screen.dart';

class RosarioMenuScreen extends StatefulWidget {
  const RosarioMenuScreen({Key? key}) : super(key: key);

  @override
  State<RosarioMenuScreen> createState() => _RosarioMenuScreenState();
}

class _RosarioMenuScreenState extends State<RosarioMenuScreen> {
  final RosarioService _rosarioService = RosarioService();
  final ScrollController _scrollController = ScrollController();
  List<RosarioInfo> _rosariosDisponibles = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _cargarRosarios();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _cargarRosarios() async {
    try {
      final rosarios = await _rosarioService.cargarRosariosDisponibles();
      setState(() {
        _rosariosDisponibles = rosarios;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error al cargar rosarios: $e')));
      }
    }
  }

  void _scrollUp() {
    _scrollController.animateTo(
      _scrollController.offset - 200,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.offset + 200,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/maria.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Overlay oscuro
          Container(color: Colors.black.withOpacity(0.4)),
          // Contenido con ScrollView
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    )
                  : _rosariosDisponibles.isEmpty
                  ? const Center(
                      child: Text(
                        'No se encontraron rosarios',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    )
                  : SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        children: [
                          const SizedBox(height: 30),
                          const Text(
                            'SELECCIONAR ROSARIO',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          const Divider(color: Colors.white70, thickness: 2),
                          const SizedBox(height: 20),

                          // Lista de rosarios
                          ..._rosariosDisponibles.map(
                            (rosario) => Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () =>
                                          _abrirRosario(rosario.slug),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.brown[700],
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.all(20),
                                        textStyle: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      child: Text(rosario.nombre),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    rosario.descripcion,
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 40),
                          const Divider(color: Colors.white70, thickness: 2),
                          const SizedBox(height: 30),

                          // Botón volver
                          SizedBox(
                            width: double.infinity,
                            height: 80,
                            child: ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.brown[600],
                                foregroundColor: Colors.white,
                                textStyle: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              child: const Text('Volver al Menú Principal'),
                            ),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
            ),
          ),
          // Botones de scroll
          Positioned(
            right: 20,
            top: 20,
            bottom: 20,
            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.brown[800],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_upward,
                      size: 40,
                      color: Colors.white,
                    ),
                    onPressed: _scrollUp,
                  ),
                ),
                const Spacer(),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.brown[800],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_downward,
                      size: 40,
                      color: Colors.white,
                    ),
                    onPressed: _scrollDown,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _abrirRosario(String slug) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RosarioScreen(slug: slug)),
    );
  }
}
