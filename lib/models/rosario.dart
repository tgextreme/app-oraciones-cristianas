class Rosario {
  final String slug;
  final String titulo;
  final List<Seccion> secciones;

  Rosario({
    required this.slug,
    required this.titulo,
    required this.secciones,
  });

  factory Rosario.fromJson(Map<String, dynamic> json) {
    return Rosario(
      slug: json['slug'] ?? '',
      titulo: json['titulo'] ?? '',
      secciones: (json['secciones'] as List<dynamic>?)
              ?.map((s) => Seccion.fromJson(s))
              .toList() ??
          [],
    );
  }
}

class Seccion {
  final int dia;
  final String titulo;
  final String oracionInicial;
  final String textoDelDia;
  final List<OracionRezar> loQueDebemosOrar;
  final String mensajeFinal;

  Seccion({
    required this.dia,
    required this.titulo,
    required this.oracionInicial,
    required this.textoDelDia,
    required this.loQueDebemosOrar,
    required this.mensajeFinal,
  });

  factory Seccion.fromJson(Map<String, dynamic> json) {
    return Seccion(
      dia: json['dia'] ?? 0,
      titulo: json['titulo'] ?? '',
      oracionInicial: json['oracion_inicial'] ?? '',
      textoDelDia: json['texto_del_dia'] ?? '',
      loQueDebemosOrar: (json['lo_que_debemos_orar'] as List<dynamic>?)
              ?.map((o) => OracionRezar.fromJson(o))
              .toList() ??
          [],
      mensajeFinal: json['mensaje_final'] ?? '',
    );
  }
}

class OracionRezar {
  final String oracion;
  final int veces;

  OracionRezar({
    required this.oracion,
    required this.veces,
  });

  factory OracionRezar.fromJson(Map<String, dynamic> json) {
    return OracionRezar(
      oracion: json['oracion'] ?? '',
      veces: json['veces'] ?? 1,
    );
  }
}
