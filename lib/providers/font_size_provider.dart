import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FontSizeProvider extends ChangeNotifier {
  double _fontSizeScale = 1.0; // 100% por defecto
  SharedPreferences? _prefs;

  double get fontSizeScale => _fontSizeScale;
  int get fontSizePercentage => (_fontSizeScale * 100).round();

  FontSizeProvider() {
    _loadFontSize();
  }

  Future<void> _loadFontSize() async {
    _prefs = await SharedPreferences.getInstance();
    _fontSizeScale = _prefs?.getDouble('fontSizeScale') ?? 1.0;
    notifyListeners();
  }

  Future<void> setFontSizeScale(double scale) async {
    _fontSizeScale = scale;
    await _prefs?.setDouble('fontSizeScale', scale);
    notifyListeners();
  }

  Future<void> setFontSizePercentage(int percentage) async {
    final scale = percentage / 100.0;
    await setFontSizeScale(scale);
  }

  // Método helper para aplicar el scale a un tamaño de fuente
  double scale(double fontSize) => fontSize * _fontSizeScale;
}
