import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/font_size_provider.dart';

class AccesibilidadScreen extends StatelessWidget {
  const AccesibilidadScreen({Key? key}) : super(key: key);

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
          Container(color: Colors.black.withOpacity(0.5)),
          // Contenido
          SafeArea(
            child: Column(
              children: [
                // Barra superior con botón de regreso
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),

                // Contenido central
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Consumer<FontSizeProvider>(
                          builder: (context, fontProvider, child) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Título
                                Text(
                                  'ACCESIBILIDAD',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: fontProvider.scale(32),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 20),
                                const Divider(
                                  color: Colors.white70,
                                  thickness: 2,
                                ),
                                const SizedBox(height: 40),

                                // Contenedor de configuración
                                Container(
                                  padding: const EdgeInsets.all(30),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.text_fields,
                                        size: fontProvider.scale(60),
                                        color: Colors.white70,
                                      ),
                                      SizedBox(height: fontProvider.scale(20)),

                                      // Título de la sección
                                      Text(
                                        'Tamaño de Letra',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: fontProvider.scale(24),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: fontProvider.scale(30)),

                                      // Muestra del porcentaje
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 15,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: Text(
                                          '${fontProvider.fontSizePercentage}%',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: fontProvider.scale(36),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: fontProvider.scale(30)),

                                      // Slider para ajustar el tamaño
                                      Column(
                                        children: [
                                          Slider(
                                            value: fontProvider
                                                .fontSizePercentage
                                                .toDouble(),
                                            min: 50,
                                            max: 200,
                                            divisions: 30,
                                            activeColor: Colors.white,
                                            inactiveColor: Colors.white
                                                .withOpacity(0.3),
                                            onChanged: (value) {
                                              fontProvider
                                                  .setFontSizePercentage(
                                                    value.round(),
                                                  );
                                            },
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 20,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '50%',
                                                  style: TextStyle(
                                                    color: Colors.white70,
                                                    fontSize: fontProvider
                                                        .scale(14),
                                                  ),
                                                ),
                                                Text(
                                                  '200%',
                                                  style: TextStyle(
                                                    color: Colors.white70,
                                                    fontSize: fontProvider
                                                        .scale(14),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: fontProvider.scale(30)),

                                      // Botones de ajuste rápido
                                      Wrap(
                                        spacing: 10,
                                        runSpacing: 10,
                                        alignment: WrapAlignment.center,
                                        children: [
                                          _buildQuickButton(
                                            context,
                                            '50%',
                                            50,
                                            fontProvider,
                                          ),
                                          _buildQuickButton(
                                            context,
                                            '75%',
                                            75,
                                            fontProvider,
                                          ),
                                          _buildQuickButton(
                                            context,
                                            '100%',
                                            100,
                                            fontProvider,
                                          ),
                                          _buildQuickButton(
                                            context,
                                            '125%',
                                            125,
                                            fontProvider,
                                          ),
                                          _buildQuickButton(
                                            context,
                                            '150%',
                                            150,
                                            fontProvider,
                                          ),
                                          _buildQuickButton(
                                            context,
                                            '200%',
                                            200,
                                            fontProvider,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: fontProvider.scale(30)),

                                      // Texto de ejemplo
                                      Container(
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.15),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Texto de ejemplo',
                                              style: TextStyle(
                                                color: Colors.white70,
                                                fontSize: fontProvider.scale(
                                                  16,
                                                ),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: fontProvider.scale(10),
                                            ),
                                            Text(
                                              'Porque de tal manera amó Dios al mundo, que ha dado a su Hijo unigénito.',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: fontProvider.scale(
                                                  18,
                                                ),
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickButton(
    BuildContext context,
    String label,
    int percentage,
    FontSizeProvider fontProvider,
  ) {
    final isSelected = fontProvider.fontSizePercentage == percentage;
    return ElevatedButton(
      onPressed: () => fontProvider.setFontSizePercentage(percentage),
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected
            ? Colors.white
            : Colors.white.withOpacity(0.2),
        foregroundColor: isSelected ? Colors.blue.shade900 : Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: fontProvider.scale(16),
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
