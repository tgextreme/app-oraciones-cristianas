import 'dart:convert';
import 'package:flutter/services.dart';

class FraseService {
  Future<List<Map<String, dynamic>>> cargarFrases() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/json/frases_seleccionadas.json',
      );
      final List<dynamic> data = json.decode(response);
      return data.cast<Map<String, dynamic>>();
    } catch (e) {
      print('Error cargando frases: $e');
      return [];
    }
  }
}
