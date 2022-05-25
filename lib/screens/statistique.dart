import 'package:flutter/material.dart';

class StatistiqueScreen extends StatefulWidget {
  const StatistiqueScreen({ Key? key }) : super(key: key);

  @override
  State<StatistiqueScreen> createState() => _StatistiqueScreenState();
}

class _StatistiqueScreenState extends State<StatistiqueScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Text('OK')),
    );
  }
}