import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'rosario_menu_screen.dart';
import 'frases_biblia_screen.dart';
import 'test_menu_screen.dart';
import 'acerca_de_screen.dart';
import 'accesibilidad_screen.dart';
import '../providers/font_size_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/principal.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Overlay oscuro
          Container(color: Colors.black.withOpacity(0.3)),
          // Contenido
          SafeArea(
            child: SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(
                  minHeight:
                      MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).padding.bottom,
                ),
                child: Center(
                  child: Container(
                    width: 600,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Título
                        Consumer<FontSizeProvider>(
                          builder: (context, fontProvider, child) {
                            return Text(
                              'APLICACIÓN BÍBLICA',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fontProvider.scale(36),
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        const Divider(color: Colors.white70, thickness: 2),
                        const SizedBox(height: 20),

                        // Botón Test Biblia
                        _buildMenuButton(
                          context,
                          'Test Biblia',
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TestMenuScreen(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Botón Rosario
                        _buildMenuButton(
                          context,
                          'Rosario',
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RosarioMenuScreen(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Botón Frases Biblia
                        _buildMenuButton(
                          context,
                          'Frases Biblia',
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const FrasesBibliaScreen(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Botón Accesibilidad
                        _buildMenuButton(
                          context,
                          'Accesibilidad',
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AccesibilidadScreen(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Botón Acerca de
                        _buildMenuButton(
                          context,
                          'Acerca de',
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AcercaDeScreen(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuButton(
    BuildContext context,
    String text,
    VoidCallback onPressed,
  ) {
    final fontProvider = Provider.of<FontSizeProvider>(context);
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[700],
          foregroundColor: Colors.white,
          textStyle: TextStyle(
            fontSize: fontProvider.scale(24),
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(text),
      ),
    );
  }
}
