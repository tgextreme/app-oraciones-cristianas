import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'providers/font_size_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => FontSizeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FontSizeProvider>(
      builder: (context, fontProvider, child) {
        return MaterialApp(
          title: 'Aplicación Bíblica',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
            textTheme: Theme.of(
              context,
            ).textTheme.apply(fontSizeFactor: fontProvider.fontSizeScale),
          ),
          home: const HomeScreen(),
        );
      },
    );
  }
}
