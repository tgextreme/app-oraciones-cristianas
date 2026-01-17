import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class RosarioFatimaScreen extends StatefulWidget {
  const RosarioFatimaScreen({Key? key}) : super(key: key);

  @override
  State<RosarioFatimaScreen> createState() => _RosarioFatimaScreenState();
}

class _RosarioFatimaScreenState extends State<RosarioFatimaScreen> {
  final ScrollController _scrollController = ScrollController();
  final PageController _pageController = PageController();

  List<dynamic>? _dias;
  bool _isLoading = true;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _cargarRosario();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _cargarRosario() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/json/rosario_fatima.json',
      );
      final data = json.decode(response) as List<dynamic>;
      setState(() {
        _dias = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error al cargar rosario: $e')));
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

  void _anteriorPagina() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _siguientePagina() {
    if (_dias != null && _currentPage < _dias!.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
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
                image: AssetImage('assets/images/maria.jpg'),
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
                  : _dias == null
                  ? const Center(
                      child: Text(
                        'No se pudo cargar el rosario',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    )
                  : PageView.builder(
                      controller: _pageController,
                      itemCount: _dias!.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                        _scrollController.jumpTo(0);
                      },
                      itemBuilder: (context, index) {
                        return _buildDiaPage(_dias![index]);
                      },
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

  Widget _buildDiaPage(Map<String, dynamic> dia) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: [
          const SizedBox(height: 30),

          // Título
          const Text(
            'NOVENA A NUESTRA SEÑORA DE FÁTIMA',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            'Día ${_currentPage + 1} de ${_dias!.length}',
            style: const TextStyle(color: Colors.white70, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          const Divider(color: Colors.white70, thickness: 2),
          const SizedBox(height: 20),

          // Contenido del día
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título del día
                Text(
                  dia['titulo'] ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                // Oración inicial
                if ((dia['oracion_inicial'] ?? '').isNotEmpty) ...[
                  const Text(
                    'ORACIÓN INICIAL:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    dia['oracion_inicial'] ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],

                // Meditación
                if ((dia['texto_del_dia'] ?? '').isNotEmpty) ...[
                  const Text(
                    'MEDITACIÓN:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    dia['texto_del_dia'] ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],

                // Oraciones a rezar
                if ((dia['lo_que_debemos_orar'] as List?)?.isNotEmpty ??
                    false) ...[
                  const Text(
                    'LO QUE DEBEMOS ORAR:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...((dia['lo_que_debemos_orar'] as List)
                      .map(
                        (oracion) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            '• ${oracion['oracion']} (${oracion['veces']} ${oracion['veces'] == 1 ? "vez" : "veces"})',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              height: 1.5,
                            ),
                          ),
                        ),
                      )
                      .toList()),
                  const SizedBox(height: 20),
                ],

                // Mensaje final
                if ((dia['mensaje_final'] ?? '').isNotEmpty) ...[
                  const Text(
                    'ORACIÓN FINAL:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    dia['mensaje_final'] ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(height: 20),
          const Divider(color: Colors.white70, thickness: 2),
          const SizedBox(height: 20),

          // Botones de navegación
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 70,
                  child: ElevatedButton(
                    onPressed: _currentPage > 0 ? _anteriorPagina : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown[700],
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text('Anterior'),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: SizedBox(
                  height: 70,
                  child: ElevatedButton(
                    onPressed: _currentPage < _dias!.length - 1
                        ? _siguientePagina
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown[700],
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text('Siguiente'),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 40),
          const Divider(color: Colors.white70, thickness: 2),
          const SizedBox(height: 30),

          // Botón volver
          SizedBox(
            width: double.infinity,
            height: 70,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown[600],
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text('Volver'),
            ),
          ),
          const SizedBox(height: 20),
          const Divider(color: Colors.white70, thickness: 2),
          const SizedBox(height: 20),

          // Botón volver al menú principal
          SizedBox(
            width: double.infinity,
            height: 70,
            child: ElevatedButton(
              onPressed: () =>
                  Navigator.of(context).popUntil((route) => route.isFirst),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown[600],
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text('Menú Principal'),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
