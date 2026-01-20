# App Oraciones Cristianas 🙏

Una aplicación móvil completa desarrollada en Flutter que ofrece recursos espirituales cristianos, incluyendo oraciones, test bíblicos, rosarios y frases inspiradoras.

## 📖 Descripción General

**App Oraciones Cristianas** es una aplicación multiplataforma diseñada para acompañar a los fieles en su vida espiritual diaria. La aplicación combina elementos educativos, devocionales y de reflexión en una interfaz intuitiva y accesible.

## ✨ Características Principales

### 🎯 Test Bíblico Interactivo
- **Cuestionarios personalizables**: Permite seleccionar entre 20, 30 o 50 preguntas
- **Base de datos extensa**: Contiene preguntas sobre conocimientos bíblicos de diversos temas
- **Sistema de evaluación**: Muestra resultados detallados al finalizar cada test
- **Interfaz educativa**: Diseñada para aprender mientras se juega
- **Historial de respuestas**: Revisión de respuestas correctas e incorrectas

### 📿 Rosarios
- **Múltiples rosarios disponibles**: Acceso a diferentes tipos de rosarios católicos
- **Rosario tradicional**: Incluye los misterios Gozosos, Dolorosos, Gloriosos y Luminosos
- **Rosario de Fátima**: Versión especial dedicada a Nuestra Señora de Fátima
- **Guía paso a paso**: Instrucciones completas para rezar cada rosario
- **Contenido estructurado**: Organizado por misterios, oraciones y meditaciones
- **Navegación intuitiva**: Fácil desplazamiento entre secciones

### 💭 Frases Bíblicas Inspiradoras
- **Frases seleccionadas**: Colección curada de versículos y citas bíblicas
- **Modo aleatorio**: Muestra una frase diferente cada vez
- **Contenido motivacional**: Mensajes de fe, esperanza y amor
- **Referencias bíblicas**: Cada frase incluye su fuente en las Escrituras
- **Interfaz visual atractiva**: Diseño que facilita la lectura y reflexión

### ♿ Accesibilidad
- **Ajuste de tamaño de fuente**: Control deslizante para modificar el tamaño del texto
- **Rango flexible**: Desde 70% hasta 150% del tamaño normal
- **Vista previa en tiempo real**: Los cambios se aplican inmediatamente
- **Persistencia de configuración**: Las preferencias se guardan usando SharedPreferences
- **Diseño inclusivo**: Facilita el acceso a usuarios con diferentes capacidades visuales

### ℹ️ Información de la Aplicación
- **Sección "Acerca de"**: Información sobre la versión y propósito de la app
- **Créditos**: Reconocimiento a desarrolladores y colaboradores
- **Descripción del proyecto**: Detalles sobre los objetivos y alcance de la aplicación

## 🛠️ Tecnologías Utilizadas

### Framework y Lenguaje
- **Flutter**: Framework de desarrollo multiplataforma (SDK ^3.10.3)
- **Dart**: Lenguaje de programación principal

### Paquetes y Dependencias
- **provider** (^6.1.2): Gestión de estado y arquitectura reactiva
- **shared_preferences** (^6.3.3): Almacenamiento local de preferencias del usuario
- **cupertino_icons** (^1.0.8): Iconos estilo iOS

### Arquitectura
- **Patrón Provider**: Para la gestión de estado global
- **Separación de responsabilidades**: 
  - Models: Estructuras de datos (Frase, Pregunta, Rosario)
  - Services: Lógica de negocio y carga de datos desde JSON
  - Screens: Interfaces de usuario
  - Providers: Gestión de estado compartido

## 📁 Estructura del Proyecto

```
lib/
├── main.dart                      # Punto de entrada de la aplicación
├── models/                        # Modelos de datos
│   ├── frase.dart
│   ├── pregunta_model.dart
│   ├── pregunta.dart
│   ├── rosario_model.dart
│   └── rosario.dart
├── providers/                     # Gestores de estado
│   └── font_size_provider.dart
├── screens/                       # Pantallas de la aplicación
│   ├── home_screen.dart          # Pantalla principal
│   ├── accesibilidad_screen.dart # Configuración de accesibilidad
│   ├── acerca_de_screen.dart     # Información de la app
│   ├── frases_biblia_screen.dart # Frases bíblicas
│   ├── rosario_menu_screen.dart  # Menú de rosarios
│   ├── rosario_screen.dart       # Visualizador de rosarios
│   ├── rosario_fatima_screen.dart# Rosario de Fátima
│   ├── test_menu_screen.dart     # Menú del test
│   ├── test_game_screen.dart     # Juego del test
│   └── test_results_screen.dart  # Resultados del test
└── services/                      # Servicios de datos
    └── (Carga de datos desde JSON)

assets/
├── images/                        # Imágenes de la aplicación
└── json/                         # Datos de la aplicación
    ├── biblia.json               # Contenido bíblico
    ├── frases_seleccionadas.json # Frases inspiradoras
    ├── preguntas_biblia.json     # Preguntas del test
    ├── rosarios_reconstruidos.json# Rosarios tradicionales
    └── rosario_fatima.json       # Rosario de Fátima
```

## 🎨 Características de Diseño

- **Tema visual coherente**: Colores e imágenes religiosas apropiadas
- **Imágenes de fondo temáticas**: Diferentes fondos para cada sección
- **Interfaz Material Design 3**: Utiliza las últimas especificaciones de Material Design
- **Responsive**: Adaptable a diferentes tamaños de pantalla
- **Overlays translúcidos**: Para mejorar la legibilidad del texto sobre imágenes
- **Navegación intuitiva**: Botones grandes y claros para facilitar la interacción

## 🚀 Funcionalidades Técnicas

### Gestión de Estado
- Uso de Provider para manejar el tamaño de fuente globalmente
- Arquitectura reactiva que actualiza la UI automáticamente

### Almacenamiento Local
- Persistencia de preferencias del usuario (tamaño de fuente)
- Uso de SharedPreferences para datos simples

### Carga de Datos
- Lectura de archivos JSON desde assets
- Deserialización de datos complejos en modelos Dart
- Manejo de errores en la carga de recursos

### Navegación
- Stack de navegación para mantener el historial
- Transiciones suaves entre pantallas
- Botones de retroceso consistentes

## 📱 Plataformas Soportadas

- ✅ Android
- ✅ iOS
- ✅ Windows
- ✅ Linux
- ✅ macOS
- ✅ Web

## 🎯 Público Objetivo

Esta aplicación está diseñada para:
- Fieles católicos que buscan recursos espirituales digitales
- Personas interesadas en aprender sobre la Biblia de forma interactiva
- Usuarios que desean tener una guía para el rezo del rosario
- Cualquier persona buscando inspiración a través de frases bíblicas
- Comunidades religiosas que necesitan herramientas educativas

## 🔄 Flujo de Usuario

1. **Pantalla Principal**: Menú con todas las opciones disponibles
2. **Selección de funcionalidad**: Test, Rosarios, Frases, Accesibilidad o Acerca de
3. **Interacción**: Uso de la funcionalidad seleccionada
4. **Retorno**: Navegación fácil de vuelta al menú principal

## 📊 Contenido de la Aplicación

- **Base de preguntas bíblicas**: Extensa colección de preguntas con múltiples opciones
- **Biblioteca de rosarios**: Múltiples versiones y misterios
- **Colección de frases**: Versículos cuidadosamente seleccionados
- **Referencias bíblicas**: Citas exactas de las Sagradas Escrituras

## 🔒 Privacidad

- **Sin recopilación de datos**: La aplicación no envía información del usuario a servidores externos
- **Almacenamiento local**: Todas las preferencias se guardan únicamente en el dispositivo
- **Sin publicidad**: Experiencia limpia y enfocada en el contenido espiritual

## 🛠️ Instalación y Desarrollo

### Requisitos
```bash
Flutter SDK: ^3.10.3
Dart SDK: Compatible con Flutter SDK
```

### Comandos de Desarrollo
```bash
# Obtener dependencias
flutter pub get

# Ejecutar en modo debug
flutter run

# Generar APK para Android
flutter build apk

# Generar IPA para iOS
flutter build ios

# Ejecutar en web
flutter run -d chrome
```

## 📝 Notas de Desarrollo

- La aplicación utiliza Material Design 3 para una apariencia moderna
- Toda la información está almacenada localmente en archivos JSON
- El sistema de temas aplica el escalado de fuente a través de Provider
- Las imágenes se cargan desde la carpeta assets/images/

## 🤝 Contribuciones

Este es un proyecto de código para uso personal y comunitario. Las contribuciones son bienvenidas para:
- Añadir más preguntas bíblicas
- Incluir nuevos rosarios
- Mejorar la accesibilidad
- Traducir a otros idiomas
- Optimizar el rendimiento

## 📄 Licencia

Proyecto desarrollado con fines educativos y espirituales.

---

**Desarrollado con ❤️ y fe en Flutter**
