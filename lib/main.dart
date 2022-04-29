import 'package:flutter/material.dart';
import 'package:marcador_truco/views/home_page.dart';

void main() {
  runApp(MarcadorDeTruco());
}

class MarcadorDeTruco extends StatelessWidget {
  const MarcadorDeTruco({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marcador de Truco',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}
