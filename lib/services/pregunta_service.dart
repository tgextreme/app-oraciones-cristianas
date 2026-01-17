import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/pregunta_model.dart';

class PreguntaService {
  Future<List<Pregunta>> cargarPreguntas() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/json/preguntas_biblia.json',
      );
      final data = json.decode(response);

      if (data['preguntas'] != null) {
        return (data['preguntas'] as List)
            .map((p) => Pregunta.fromJson(p))
            .toList();
      }
      return [];
    } catch (e) {
      print('Error cargando preguntas: $e');
      return [];
    }
  }
}
