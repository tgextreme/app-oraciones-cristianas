import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade900,
              Colors.blue.shade700,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Título de la app
                  const Icon(
                    Icons.church,
                    size: 80,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Oraciones y Test\nCristianos',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 50),

                  // Botones del menú
                  _buildMenuButton(
                    context,
                    icon: Icons.book,
                    label: 'Test Bíblico',
                    onPressed: () => Navigator.pushNamed(context, '/test'),
                  ),
                  const SizedBox(height: 15),
                  _buildMenuButton(
                    context,
                    icon: Icons.favorite,
                    label: 'Rosario',
                    onPressed: () =>
                        Navigator.pushNamed(context, '/rosario-menu'),
                  ),
                  const SizedBox(height: 15),
                  _buildMenuButton(
                    context,
                    icon: Icons.format_quote,
                    label: 'Frases Bíblicas',
                    onPressed: () => Navigator.pushNamed(context, '/frases'),
                  ),
                  const SizedBox(height: 15),
                  _buildMenuButton(
                    context,
                    icon: Icons.info,
                    label: 'Acerca De',
                    onPressed: () => Navigator.pushNamed(context, '/acerca-de'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.blue.shade900,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
