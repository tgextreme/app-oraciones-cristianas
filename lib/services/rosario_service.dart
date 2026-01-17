import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/rosario_model.dart';

class RosarioService {
  Future<List<RosarioInfo>> cargarRosariosDisponibles() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/json/rosarios_reconstruidos.json',
      );
      final data = json.decode(response);

      if (data['rosarios'] != null) {
        final List rosarios = data['rosarios'];
        return rosarios.map((r) {
          final secciones = r['secciones'] as List? ?? [];
          return RosarioInfo(
            slug: r['slug'] ?? '',
            nombre: r['titulo'] ?? 'Rosario sin título',
            descripcion: 'Rosario con ${secciones.length} secciones',
          );
        }).toList();
      }
      return [];
    } catch (e) {
      print('Error cargando rosarios: $e');
      return [];
    }
  }

  Future<Rosario?> cargarRosarioPorSlug(String slug) async {
    try {
      final String response = await rootBundle.loadString(
        'assets/json/rosarios_reconstruidos.json',
      );
      final data = json.decode(response);

      if (data['rosarios'] != null) {
        final List rosarios = data['rosarios'];
        final rosarioData = rosarios.firstWhere(
          (r) => r['slug'] == slug,
          orElse: () => null,
        );

        if (rosarioData != null) {
          return Rosario.fromJson(rosarioData);
        }
      }
      return null;
    } catch (e) {
      print('Error cargando rosario: $e');
      return null;
    }
  }
}
