import 'package:flutter/material.dart';
import '../services/frase_service.dart';
import 'dart:math';

class FrasesBibliaScreen extends StatefulWidget {
  const FrasesBibliaScreen({Key? key}) : super(key: key);

  @override
  State<FrasesBibliaScreen> createState() => _FrasesBibliaScreenState();
}

class _FrasesBibliaScreenState extends State<FrasesBibliaScreen> {
  final FraseService _fraseService = FraseService();
  final Random _random = Random();

  List<Map<String, dynamic>> _frases = [];
  Map<String, dynamic>? _fraseActual;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _cargarFrases();
  }

  Future<void> _cargarFrases() async {
    try {
      final frases = await _fraseService.cargarFrases();
      setState(() {
        _frases = frases;
        _isLoading = false;
      });
      if (_frases.isNotEmpty) {
        _mostrarFraseAleatoria();
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error al cargar frases: $e')));
      }
    }
  }

  void _mostrarFraseAleatoria() {
    if (_frases.isNotEmpty) {
      setState(() {
        _fraseActual = _frases[_random.nextInt(_frases.length)];
      });
    }
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
                image: AssetImage('assets/images/jesus.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Overlay oscuro
          Container(color: Colors.black.withOpacity(0.4)),
          // Contenido
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    )
                  : _frases.isEmpty
                  ? const Center(
                      child: Text(
                        'No se encontraron frases bíblicas',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    )
                  : Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 30),
                            const Text(
                              'FRASES BÍBLICAS',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            const Divider(color: Colors.white70, thickness: 2),
                            const SizedBox(height: 40),

                            if (_fraseActual != null) ...[
                              // Contenedor de la frase
                              Container(
                                padding: const EdgeInsets.all(30),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    const Icon(
                                      Icons.format_quote,
                                      size: 50,
                                      color: Colors.white70,
                                    ),
                                    const SizedBox(height: 20),

                                    // Texto de la frase
                                    Text(
                                      _fraseActual!['frase'] ?? '',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        height: 1.6,
                                        fontStyle: FontStyle.italic,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 30),

                              // Referencia
                              Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  '${_fraseActual!['libro'] ?? ''} ${_fraseActual!['capitulo'] ?? ''}, ${_fraseActual!['versiculo'] ?? ''}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],

                            const SizedBox(height: 40),
                            const Divider(color: Colors.white70, thickness: 2),
                            const SizedBox(height: 30),

                            // Botón para nueva frase
                            SizedBox(
                              width: double.infinity,
                              height: 80,
                              child: ElevatedButton(
                                onPressed: _mostrarFraseAleatoria,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.indigo[700],
                                  foregroundColor: Colors.white,
                                  textStyle: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                child: const Text('Otra Frase'),
                              ),
                            ),

                            const SizedBox(height: 20),
                            const Divider(color: Colors.white70, thickness: 2),
                            const SizedBox(height: 20),

                            // Botón volver
                            SizedBox(
                              width: double.infinity,
                              height: 80,
                              child: ElevatedButton(
                                onPressed: () => Navigator.of(
                                  context,
                                ).popUntil((route) => route.isFirst),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.indigo[600],
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
          ),
        ],
      ),
    );
  }
}
