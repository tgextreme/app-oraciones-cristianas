import 'package:flutter/material.dart';
import 'test_game_screen.dart';

class TestMenuScreen extends StatelessWidget {
  const TestMenuScreen({Key? key}) : super(key: key);

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
          Container(color: Colors.black.withOpacity(0.3)),
          // Contenido
          SafeArea(
            child: Center(
              child: Container(
                width: 600,
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'TEST BÍBLICO',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      const Divider(color: Colors.white70, thickness: 2),
                      const SizedBox(height: 20),

                      const Text(
                        'Selecciona la cantidad de preguntas para tu test:',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
                      const Divider(color: Colors.white70, thickness: 2),
                      const SizedBox(height: 20),

                      _buildQuestionButton(context, 20),
                      const SizedBox(height: 20),
                      _buildQuestionButton(context, 30),
                      const SizedBox(height: 20),
                      _buildQuestionButton(context, 50),

                      const SizedBox(height: 40),
                      const Divider(color: Colors.white70, thickness: 2),
                      const SizedBox(height: 30),

                      SizedBox(
                        width: double.infinity,
                        height: 100,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
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
                      const SizedBox(height: 20),
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

  Widget _buildQuestionButton(BuildContext context, int numQuestions) {
    return SizedBox(
      width: double.infinity,
      height: 90,
      child: ElevatedButton(
        onPressed: () => _startTest(context, numQuestions),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal[700],
          foregroundColor: Colors.white,
          textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        child: Text('$numQuestions Preguntas'),
      ),
    );
  }

  void _startTest(BuildContext context, int numQuestions) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TestGameScreen(numQuestions: numQuestions),
      ),
    );
  }
}
