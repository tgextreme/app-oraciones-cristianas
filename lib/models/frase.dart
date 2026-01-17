class Frase {
  final String libro;
  final String capitulo;
  final String versiculo;
  final String texto;

  Frase({
    required this.libro,
    required this.capitulo,
    required this.versiculo,
    required this.texto,
  });

  factory Frase.fromJson(Map<String, dynamic> json) {
    return Frase(
      libro: json['libro'] ?? '',
      capitulo: json['capitulo'] ?? '',
      versiculo: json['versiculo'] ?? '',
      texto: json['texto'] ?? '',
    );
  }

  String get referencia => '$libro $capitulo, $versiculo';
}
