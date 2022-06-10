import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class Chart {
  final int solde;
  final String mois;
  final charts.Color color;

  Chart(this.solde, this.mois, Color color)
      : this.color = charts.Color(
            g: color.green, r: color.red, a: color.alpha, b: color.blue);
}
