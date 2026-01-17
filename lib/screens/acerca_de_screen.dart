import 'package:flutter/material.dart';

class AcercaDeScreen extends StatefulWidget {
  const AcercaDeScreen({Key? key}) : super(key: key);

  @override
  State<AcercaDeScreen> createState() => _AcercaDeScreenState();
}

class _AcercaDeScreenState extends State<AcercaDeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
          // Fondo de color
          Container(color: const Color(0xFF4D7C6E)),
          // Contenido con ScrollView
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    const Text(
                      'ACERCA DE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    const Divider(color: Colors.white70, thickness: 2),
                    const SizedBox(height: 30),

                    // Contenido de información
                    Container(
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Column(
                        children: [
                          Text(
                            'Tomas González',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),

                          Text(
                            'Desarrollador de aplicaciones bíblicas',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 30),

                          Text(
                            'Esta aplicación fue creada con el propósito de ayudar en el estudio y la reflexión de la Palabra de Dios a través de:',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),

                          Text(
                            '• Tests bíblicos interactivos',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              height: 1.8,
                            ),
                          ),
                          Text(
                            '• Guía para el rezo del rosario',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              height: 1.8,
                            ),
                          ),
                          Text(
                            '• Frases inspiradoras de las Escrituras',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              height: 1.8,
                            ),
                          ),
                          SizedBox(height: 30),

                          Text(
                            '"La palabra de Dios es viva y eficaz" - Hebreos 4, 12',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),
                    const Divider(color: Colors.white70, thickness: 2),
                    const SizedBox(height: 20),

                    // Botón volver
                    SizedBox(
                      width: double.infinity,
                      height: 80,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal[700],
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
                    color: Colors.teal[800],
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
                    color: Colors.teal[800],
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
}
