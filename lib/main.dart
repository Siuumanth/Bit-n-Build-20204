import 'package:flutter/material.dart';
import '../screens/home.dart';

void main() {
  runApp(StyleSort());
}

class StyleSort extends StatefulWidget {
  const StyleSort({super.key});

  @override
  State<StyleSort> createState() => _StyeSortState();
}

class _StyeSortState extends State<StyleSort> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
