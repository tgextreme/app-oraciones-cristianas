import 'package:flutter/material.dart';
import '../models/pregunta_model.dart';
import '../services/pregunta_service.dart';
import 'test_results_screen.dart';
import 'dart:math';

class TestGameScreen extends StatefulWidget {
  final int numQuestions;

  const TestGameScreen({Key? key, required this.numQuestions})
    : super(key: key);

  @override
  State<TestGameScreen> createState() => _TestGameScreenState();
}

class _TestGameScreenState extends State<TestGameScreen> {
  final PreguntaService _preguntaService = PreguntaService();
  final Random _random = Random();
  final ScrollController _scrollController = ScrollController();

  List<Pregunta> _preguntas = [];
  List<int> _respuestasUsuario = [];
  int _preguntaActual = 0;
  int _respuestasCorrectas = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _cargarPreguntas();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _cargarPreguntas() async {
    try {
      final todasPreguntas = await _preguntaService.cargarPreguntas();

      final preguntasSeleccionadas = <Pregunta>[];
      final indicesUsados = <int>{};

      while (preguntasSeleccionadas.length < widget.numQuestions &&
          preguntasSeleccionadas.length < todasPreguntas.length) {
        final indice = _random.nextInt(todasPreguntas.length);
        if (!indicesUsados.contains(indice)) {
          indicesUsados.add(indice);
          preguntasSeleccionadas.add(todasPreguntas[indice]);
        }
      }

      setState(() {
        _preguntas = preguntasSeleccionadas;
        _respuestasUsuario = List.filled(preguntasSeleccionadas.length, -1);
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al cargar preguntas: $e')),
        );
      }
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
                image: AssetImage('assets/images/principal1.jpg'),
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
                  : _preguntas.isEmpty
                  ? const Center(
                      child: Text(
                        'No se encontraron preguntas',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    )
                  : SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        children: [
                          const SizedBox(height: 30),

                          // Barra de progreso
                          Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Pregunta ${_preguntaActual + 1} de ${_preguntas.length}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Correctas: $_respuestasCorrectas',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20),
                          const Divider(color: Colors.white70, thickness: 2),
                          const SizedBox(height: 20),

                          // Pregunta
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              _preguntas[_preguntaActual].pregunta,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          const SizedBox(height: 20),
                          const Divider(color: Colors.white70, thickness: 2),
                          const SizedBox(height: 20),

                          // Opciones
                          ..._preguntas[_preguntaActual].opciones
                              .asMap()
                              .entries
                              .map((entry) {
                                final index = entry.key;
                                final opcion = entry.value;
                                final isSelected =
                                    _respuestasUsuario[_preguntaActual] ==
                                    index;

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 80,
                                    child: ElevatedButton(
                                      onPressed: () =>
                                          _seleccionarOpcion(index),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: isSelected
                                            ? Colors.yellow[700]
                                            : Colors.teal[700],
                                        foregroundColor: isSelected
                                            ? Colors.black
                                            : Colors.white,
                                        textStyle: TextStyle(
                                          fontSize: 18,
                                          fontWeight: isSelected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                      ),
                                      child: Text(opcion),
                                    ),
                                  ),
                                );
                              }),

                          const SizedBox(height: 20),
                          const Divider(color: Colors.white70, thickness: 2),
                          const SizedBox(height: 20),

                          // Botones de navegación
                          Row(
                            children: [
                              if (_preguntaActual > 0)
                                Expanded(
                                  child: SizedBox(
                                    height: 80,
                                    child: ElevatedButton(
                                      onPressed: _preguntaAnterior,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.teal[600],
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
                              if (_preguntaActual > 0)
                                const SizedBox(width: 20),
                              Expanded(
                                child: SizedBox(
                                  height: 80,
                                  child: ElevatedButton(
                                    onPressed:
                                        _preguntaActual < _preguntas.length - 1
                                        ? _preguntaSiguiente
                                        : _finalizarTest,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          _preguntaActual <
                                              _preguntas.length - 1
                                          ? Colors.teal[600]
                                          : Colors.orange[700],
                                      foregroundColor: Colors.white,
                                      textStyle: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    child: Text(
                                      _preguntaActual < _preguntas.length - 1
                                          ? 'Siguiente'
                                          : 'Finalizar Test',
                                    ),
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
                            height: 80,
                            child: ElevatedButton(
                              onPressed: () => Navigator.of(
                                context,
                              ).popUntil((route) => route.isFirst),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal[600],
                                foregroundColor: Colors.white,
                                textStyle: const TextStyle(
                                  fontSize: 20,
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
        ],
      ),
    );
  }

  void _seleccionarOpcion(int index) {
    setState(() {
      _respuestasUsuario[_preguntaActual] = index;
    });
  }

  void _preguntaAnterior() {
    if (_preguntaActual > 0) {
      setState(() {
        _preguntaActual--;
      });
      _scrollController.jumpTo(0);
    }
  }

  void _preguntaSiguiente() {
    if (_preguntaActual < _preguntas.length - 1) {
      setState(() {
        _preguntaActual++;
      });
      _scrollController.jumpTo(0);
    }
  }

  void _finalizarTest() {
    int correctas = 0;
    for (int i = 0; i < _preguntas.length; i++) {
      if (_respuestasUsuario[i] == _preguntas[i].respuestaCorrecta) {
        correctas++;
      }
    }

    setState(() {
      _respuestasCorrectas = correctas;
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => TestResultsScreen(
          preguntas: _preguntas,
          respuestasUsuario: _respuestasUsuario,
          respuestasCorrectas: correctas,
        ),
      ),
    );
  }
}
