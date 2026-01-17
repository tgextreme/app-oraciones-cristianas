import 'package:flutter/material.dart';
import '../models/rosario_model.dart';
import '../services/rosario_service.dart';

class RosarioScreen extends StatefulWidget {
  final String slug;

  const RosarioScreen({Key? key, required this.slug}) : super(key: key);

  @override
  State<RosarioScreen> createState() => _RosarioScreenState();
}

class _RosarioScreenState extends State<RosarioScreen> {
  final RosarioService _rosarioService = RosarioService();
  final ScrollController _scrollController = ScrollController();
  final PageController _pageController = PageController();

  Rosario? _rosario;
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
      final rosario = await _rosarioService.cargarRosarioPorSlug(widget.slug);
      setState(() {
        _rosario = rosario;
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
    if (_rosario != null && _currentPage < _rosario!.secciones.length - 1) {
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
                  : _rosario == null
                  ? const Center(
                      child: Text(
                        'No se pudo cargar el rosario',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    )
                  : PageView.builder(
                      controller: _pageController,
                      itemCount: _rosario!.secciones.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                        _scrollController.jumpTo(0);
                      },
                      itemBuilder: (context, index) {
                        return _buildSeccionPage(_rosario!.secciones[index]);
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

  Widget _buildSeccionPage(SeccionRosario seccion) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: [
          const SizedBox(height: 30),

          // Título y número de página
          Text(
            _rosario!.titulo.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            'Página ${_currentPage + 1} de ${_rosario!.secciones.length}',
            style: const TextStyle(color: Colors.white70, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          const Divider(color: Colors.white70, thickness: 2),
          const SizedBox(height: 20),

          // Contenido de la sección
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título de la sección
                Text(
                  seccion.titulo,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                // Oración inicial
                if (seccion.oracionInicial.isNotEmpty) ...[
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
                    seccion.oracionInicial,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],

                // Meditación
                if (seccion.textoDelDia.isNotEmpty) ...[
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
                    seccion.textoDelDia,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],

                // Oraciones a rezar
                if (seccion.loQueDebemosOrar.isNotEmpty) ...[
                  const Text(
                    'LO QUE DEBEMOS ORAR:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...seccion.loQueDebemosOrar.map(
                    (oracion) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        '• ${oracion.oracion} (${oracion.veces} ${oracion.veces == 1 ? "vez" : "veces"})',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],

                // Mensaje final
                if (seccion.mensajeFinal.isNotEmpty) ...[
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
                    seccion.mensajeFinal,
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
                    onPressed: _currentPage < _rosario!.secciones.length - 1
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

          // Botones volver
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
              child: const Text('Volver a Rosarios'),
            ),
          ),
          const SizedBox(height: 20),
          const Divider(color: Colors.white70, thickness: 2),
          const SizedBox(height: 20),
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
