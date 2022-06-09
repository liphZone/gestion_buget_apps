import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gestion_buget_apps/models/chart_mdl.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ChartScreen extends StatefulWidget {
  const ChartScreen({Key? key}) : super(key: key);

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  double janv_solde_global = 0;
  double fev_solde_global = 0;
  double mar_solde_global = 0;
  double avr_solde_global = 0;
  double mai_solde_global = 0;
  double jun_solde_global = 0;
  double jul_solde_global = 0;
  double aou_solde_global = 0;
  double sept_solde_global = 0;
  double oct_solde_global = 0;
  double nov_solde_global = 0;
  double dec_solde_global = 0;
  //Je recupere les depenses individuellement suivant le mois pour le graphique
  Future monthData() async {
    try {
      for (var i = 0; i < 11; i++) {
        await FirebaseFirestore.instance
            .collection('comptes')
            .where('mois_int', isEqualTo: i)
            .get()
            .then((snapshot) {
          double total_solde = 0.0;

          for (var counter = 0; counter < snapshot.docs.length; counter++) {
            total_solde += snapshot.docs[counter]['solde'];
          }

          setState(() {
            switch (i) {
              case 1:
                janv_solde_global = total_solde;
                break;

              case 2:
                fev_solde_global = total_solde;
                break;
              case 3:
                mar_solde_global = total_solde;
                break;
              case 4:
                avr_solde_global = total_solde;
                break;
              case 5:
                mai_solde_global = total_solde;
                break;
              case 6:
                jun_solde_global = total_solde;
                break;
              case 7:
                jul_solde_global = total_solde;
                break;
              case 8:
                aou_solde_global = total_solde;
                break;
              case 9:
                sept_solde_global = total_solde;
                break;
              case 10:
                oct_solde_global = total_solde;
                break;
              case 11:
                nov_solde_global = total_solde;
                break;
              case 12:
                dec_solde_global = total_solde;
                break;

              default:
            }
          });
        });
      }
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Erreur $e')));
    }
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    monthData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var data = [
      Chart(janv_solde_global.toInt(), 'Janv', Colors.amber),
      Chart(fev_solde_global.toInt(), 'Fév', Colors.blue),
      Chart(mar_solde_global.toInt(), 'Mar', Colors.cyan),
      Chart(avr_solde_global.toInt(), 'Avr', Colors.yellow),
      Chart(mai_solde_global.toInt(), 'Mai', Colors.indigo),
      Chart(jun_solde_global.toInt(), 'Jun', Colors.green),
      Chart(jul_solde_global.toInt(), 'Jul', Colors.lime),
      Chart(aou_solde_global.toInt(), 'Aou', Colors.grey),
      Chart(sept_solde_global.toInt(), 'Sept', Colors.orange),
      Chart(oct_solde_global.toInt(), 'Oct', Colors.pink),
      Chart(nov_solde_global.toInt(), 'Nov', Colors.red),
      Chart(dec_solde_global.toInt(), 'Déc', Colors.teal),
    ];

    var series = [
      charts.Series(
        domainFn: (Chart chart, _) => chart.mois,
        measureFn: (Chart chart, _) => chart.solde,
        colorFn: (Chart chart, _) => chart.color,
        id: 'Solde mensuel',
        data: data,
        labelAccessorFn: (Chart chart, _) => '${chart.solde}',
      ),
    ];

    var chart = charts.BarChart(
      series,
      vertical: true,
      barRendererDecorator: charts.BarLabelDecorator(),
      animationDuration: Duration(seconds: 1),
    );

    return Scaffold(
      body: SafeArea(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                        child: Text(
                      'Graphe des dépenses mensuelles',
                      style: TextStyle(fontSize: 20),
                    )),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: chart,
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
