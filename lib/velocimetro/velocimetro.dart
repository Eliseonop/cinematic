import 'package:cinematic/velocimetro/velocimetro_widget.dart';
import 'package:flutter/material.dart';

class VelocimetroApp extends StatefulWidget {
  @override
  _VelocimetroAppState createState() => _VelocimetroAppState();
}

class _VelocimetroAppState extends State<VelocimetroApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Velocímetro App'),
      ),
      body: Center(
        child: VelocimetroWidget(),
      ),
    );
  }
}
