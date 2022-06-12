import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodayOutlayScreen extends StatefulWidget {
  const TodayOutlayScreen({Key? key}) : super(key: key);

  @override
  State<TodayOutlayScreen> createState() => _TodayOutlayScreenState();
}

class _TodayOutlayScreenState extends State<TodayOutlayScreen> {
  double total_solde_global = 0;
  double total_logement_global = 0;
  double total_food_global = 0;
  double total_clothing_global = 0;
  double total_deplacement_global = 0;
  double total_education_global = 0;
  double total_divers_global = 0;
  double percent_logement_global = 0;
  double percent_food_global = 0;
  double percent_clothing_global = 0;
  double percent_deplacement_global = 0;
  double percent_education_global = 0;
  double percent_divers_global = 0;

  Future readMonthOutlay() async {
    try {
      await FirebaseFirestore.instance
          .collection('comptes')
          .where('date',
              isEqualTo: DateFormat("dd MM yyyy").format(DateTime.now()))
          .get()
          .then((snapshot) {
        double total_solde = 0.0;
        double total_logement = 0.0;
        double total_alimentation = 0.0;
        double total_habillement = 0.0;
        double total_deplacement = 0.0;
        double total_education = 0.0;
        double total_divers = 0.0;
        double pers_food = 0;
        for (var counter = 0; counter < snapshot.docs.length; counter++) {
          total_solde += snapshot.docs[counter]['solde'];
          total_logement += snapshot.docs[counter]['montant_logement'];
          total_alimentation += snapshot.docs[counter]['montant_alimentation'];
          total_habillement += snapshot.docs[counter]['montant_habillement'];
          total_deplacement += snapshot.docs[counter]['montant_deplacement'];
          total_education += snapshot.docs[counter]['montant_education'];
          total_divers += snapshot.docs[counter]['montant_divers'];
        }

        double total_depense = total_logement +
            total_alimentation +
            total_habillement +
            total_deplacement +
            total_education +
            total_divers;

        double total_reste = total_solde - total_depense;

        setState(() {
          total_solde_global = total_solde;
          total_logement_global = total_logement;
          total_food_global = total_alimentation;
          total_clothing_global = total_habillement;
          total_deplacement_global = total_deplacement;
          total_education_global = total_education;
          total_divers_global = total_divers;

          if (total_solde_global != 0) {
            percent_logement_global =
                total_logement_global * 100 / total_solde_global;
            percent_food_global = total_food_global * 100 / total_solde_global;
            percent_clothing_global =
                total_clothing_global * 100 / total_solde_global;
            percent_deplacement_global =
                total_deplacement_global * 100 / total_solde_global;
            percent_education_global =
                total_education_global * 100 / total_solde_global;
            percent_divers_global =
                total_divers_global * 100 / total_solde_global;
          } else {
            percent_logement_global = 0;
            percent_food_global = 0;
            percent_clothing_global = 0;
            percent_deplacement_global = 0;
            percent_education_global = 0;
            percent_divers_global = 0;
          }
        });
      });
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Erreur $e')));
    }
  }

  @override
  void initState() {
    readMonthOutlay();
    super.initState();
  }

  @override
  void dispose() {
    readMonthOutlay();
    super.dispose();
  }

   @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.all(5),
                  height: height * 0.1,
                  width: width,
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(blurRadius: 1),
                  ]),
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.all(2),
                        height: double.infinity,
                        width: double.infinity,
                        child: LinearProgressIndicator(
                          value: total_solde_global == 0 ? 0 : 1,
                          color: Colors.blue,
                          backgroundColor: Colors.white,
                        ),
                      ),
                      Align(
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.money),
                              Text('Solde'),
                              Text('$total_solde_global F CFA'),
                              Text(total_solde_global == 0 ? '0 %' : '100 %'),
                            ],
                          ),
                        ),
                        alignment: Alignment.topCenter,
                      ),
                    ],
                  )),
              Container(
                  margin: EdgeInsets.all(5),
                  height: height * 0.1,
                  width: width,
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(blurRadius: 1),
                  ]),
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.all(2),
                        height: double.infinity,
                        width: double.infinity,
                        child: LinearProgressIndicator(
                          value: percent_logement_global / 100,
                          color: Colors.blue,
                          backgroundColor: Colors.white,
                        ),
                      ),
                      Align(
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.house_outlined),
                              Text('Logement'),
                              Text('$total_logement_global F CFA'),
                              Text(
                                  '${percent_logement_global.roundToDouble()} %'),
                            ],
                          ),
                        ),
                        alignment: Alignment.topCenter,
                      ),
                    ],
                  )),
              Container(
                  margin: EdgeInsets.all(5),
                  height: height * 0.1,
                  width: width,
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(blurRadius: 1),
                  ]),
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.all(2),
                        height: double.infinity,
                        width: double.infinity,
                        child: LinearProgressIndicator(
                          value: percent_food_global / 100,
                          color: Colors.blue,
                          backgroundColor: Colors.white,
                        ),
                      ),
                      Align(
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.restaurant_menu_rounded),
                              Text('Nourriture'),
                              Text('$total_food_global F CFA'),
                              Text('${percent_food_global.roundToDouble()} %'),
                            ],
                          ),
                        ),
                        alignment: Alignment.topCenter,
                      ),
                    ],
                  )),
              Container(
                  margin: EdgeInsets.all(5),
                  height: height * 0.1,
                  width: width,
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(blurRadius: 1),
                  ]),
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.all(2),
                        height: double.infinity,
                        width: double.infinity,
                        child: LinearProgressIndicator(
                          value: percent_clothing_global / 100,
                          color: Colors.blue,
                          backgroundColor: Colors.white,
                        ),
                      ),
                      Align(
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.shopping_bag),
                              Text('Habillement'),
                              Text('$total_clothing_global F CFA'),
                              Text(
                                  '${percent_clothing_global.roundToDouble()} %'),
                            ],
                          ),
                        ),
                        alignment: Alignment.topCenter,
                      ),
                    ],
                  )),
              Container(
                  margin: EdgeInsets.all(5),
                  height: height * 0.1,
                  width: width,
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(blurRadius: 1),
                  ]),
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.all(2),
                        height: double.infinity,
                        width: double.infinity,
                        child: LinearProgressIndicator(
                          value: percent_deplacement_global / 100,
                          color: Colors.blue,
                          backgroundColor: Colors.white,
                        ),
                      ),
                      Align(
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.drive_eta),
                              Text('Deplacement'),
                              Text('$total_deplacement_global F CFA'),
                              Text(
                                  '${percent_deplacement_global.roundToDouble()} %'),
                            ],
                          ),
                        ),
                        alignment: Alignment.topCenter,
                      ),
                    ],
                  )),
              Container(
                  margin: EdgeInsets.all(5),
                  height: height * 0.1,
                  width: width,
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(blurRadius: 1),
                  ]),
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.all(2),
                        height: double.infinity,
                        width: double.infinity,
                        child: LinearProgressIndicator(
                          value: percent_education_global / 100,
                          color: Colors.blue,
                          backgroundColor: Colors.white,
                        ),
                      ),
                      Align(
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.school),
                              Text('Education'),
                              Text('$total_education_global F CFA'),
                              Text(
                                  '${percent_education_global.roundToDouble()} %'),
                            ],
                          ),
                        ),
                        alignment: Alignment.topCenter,
                      ),
                    ],
                  )),
              Container(
                  margin: EdgeInsets.all(5),
                  height: height * 0.1,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(blurRadius: 1),
                  ]),
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.all(2),
                        height: double.infinity,
                        width: double.infinity,
                        child: LinearProgressIndicator(
                          value: percent_divers_global / 100,
                          color: Colors.blue,
                          backgroundColor: Colors.white,
                        ),
                      ),
                      Align(
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.miscellaneous_services),
                              Text('Divers'),
                              Text('$total_divers_global F CFA'),
                              Text(
                                  '${percent_divers_global.roundToDouble()} %'),
                            ],
                          ),
                        ),
                        alignment: Alignment.topCenter,
                      ),
                    ],
                  )),
            ],
          )),
    )));
  }
}
