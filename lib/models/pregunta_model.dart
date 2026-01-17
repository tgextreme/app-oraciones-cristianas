class Pregunta {
  final String pregunta;
  final List<String> opciones;
  final int respuestaCorrecta;

  Pregunta({
    required this.pregunta,
    required this.opciones,
    required this.respuestaCorrecta,
  });

  factory Pregunta.fromJson(Map<String, dynamic> json) {
    return Pregunta(
      pregunta: json['pregunta'] ?? '',
      opciones: List<String>.from(json['opciones'] ?? []),
      respuestaCorrecta: json['respuesta_correcta'] ?? 0,
    );
  }
}
