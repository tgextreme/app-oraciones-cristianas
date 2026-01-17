import 'package:flutter/material.dart';
import '../models/pregunta_model.dart';
import 'test_game_screen.dart';

class TestResultsScreen extends StatelessWidget {
  final List<Pregunta> preguntas;
  final List<int> respuestasUsuario;
  final int respuestasCorrectas;

  const TestResultsScreen({
    Key? key,
    required this.preguntas,
    required this.respuestasUsuario,
    required this.respuestasCorrectas,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final porcentaje = (respuestasCorrectas / preguntas.length * 100).round();

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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 30),

                    // Encabezado de resultados
                    const Text(
                      'RESULTADOS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),

                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.assessment,
                            size: 60,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            '$respuestasCorrectas de ${preguntas.length} correctas',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '($porcentaje%)',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),
                    const Divider(color: Colors.white70, thickness: 2),
                    const SizedBox(height: 20),

                    // Lista de preguntas y respuestas
                    ...preguntas.asMap().entries.map((entry) {
                      final index = entry.key;
                      final pregunta = entry.value;
                      return _buildQuestionResult(index, pregunta);
                    }),

                    const SizedBox(height: 40),
                    const Divider(color: Colors.white70, thickness: 2),
                    const SizedBox(height: 20),

                    // Botones de acción
                    SizedBox(
                      width: double.infinity,
                      height: 80,
                      child: ElevatedButton(
                        onPressed: () => _reiniciarTest(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal[700],
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: const Text('Repetir Test'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 80,
                      child: ElevatedButton(
                        onPressed: () => _volverAlMenu(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal[600],
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
        ],
      ),
    );
  }

  Widget _buildQuestionResult(int index, Pregunta pregunta) {
    final respuestaUsuario = respuestasUsuario[index];
    final esCorrecto = respuestaUsuario == pregunta.respuestaCorrecta;
    final sinResponder = respuestaUsuario == -1;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Encabezado de la pregunta
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: esCorrecto
                      ? Colors.green
                      : sinResponder
                      ? Colors.orange
                      : Colors.red,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  esCorrecto
                      ? '✓ CORRECTO'
                      : sinResponder
                      ? '○ SIN RESPONDER'
                      : '✗ INCORRECTO',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Pregunta ${index + 1}',
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 15),

          // Texto de la pregunta
          Text(
            pregunta.pregunta,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 15),

          // Opciones
          ...pregunta.opciones.asMap().entries.map((entry) {
            final i = entry.key;
            final opcion = entry.value;
            final esRespuestaCorrecta = i == pregunta.respuestaCorrecta;
            final esRespuestaUsuario = i == respuestaUsuario;

            Color textColor = Colors.white70;
            String prefix = '  ${String.fromCharCode(65 + i)}) ';

            if (esRespuestaCorrecta) {
              textColor = Colors.green;
              prefix = '✓ ${String.fromCharCode(65 + i)}) ';
            } else if (esRespuestaUsuario && !esRespuestaCorrecta) {
              textColor = Colors.red;
              prefix = '✗ ${String.fromCharCode(65 + i)}) ';
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                prefix + opcion,
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: esRespuestaCorrecta || esRespuestaUsuario
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  void _reiniciarTest(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => TestGameScreen(numQuestions: preguntas.length),
      ),
    );
  }

  void _volverAlMenu(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}
