import 'package:flutter/material.dart';

import 'screens/inicio_screen.dart';
import 'tema.dart';

void main() {
  runApp(const TrunfoAtomicoApp());
}

class TrunfoAtomicoApp extends StatelessWidget {
  const TrunfoAtomicoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trunfo Atômico',
      debugShowCheckedModeBanner: false,
      theme: temaDoApp(),
      home: const InicioScreen(),
    );
  }
}
