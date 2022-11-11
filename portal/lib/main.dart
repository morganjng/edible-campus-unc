import 'package:flutter/material.dart';

ThemeData theme =
    ThemeData(colorSchemeSeed: const Color(0xFF62C6F2), useMaterial3: true);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edible Campus UNC Admin Portal',
      theme: theme,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Text("aouaeu");
  }
}
