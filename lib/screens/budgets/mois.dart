import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthOutlayScreen extends StatefulWidget {
  const MonthOutlayScreen({Key? key}) : super(key: key);

  @override
  State<MonthOutlayScreen> createState() => _MonthOutlayScreenState();
}

class _MonthOutlayScreenState extends State<MonthOutlayScreen> {
  String? mois1 = DateFormat.LLLL().format(DateTime.now());
  var mois = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    'December'
  ];

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
          .where('mois', isEqualTo: mois1)
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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DropdownButton(
                value: mois1,
                items: mois.map((String item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    mois1 = newValue!;
                    readMonthOutlay();
                  });
                },
              ),
            ],
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    margin: EdgeInsets.all(5),
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Row(
                        children: [
                          Icon(Icons.house_outlined),
                          Text('Logement'),
                        ],
                      ),
                      subtitle: LinearProgressIndicator(
                        color: Colors.red,
                        minHeight: 15,
                        value: percent_logement_global / 100,
                      ),
                      trailing: Text('$total_logement_global F CFA'),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Row(
                        children: [
                          Icon(Icons.restaurant_menu_rounded),
                          Text('Nourriture'),
                        ],
                      ),
                      subtitle: LinearProgressIndicator(
                        color: Colors.red,
                        minHeight: 15,
                        value: percent_food_global / 100,
                      ),
                      trailing: Text('$total_food_global F CFA'),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Row(
                        children: [
                          Icon(Icons.shopify_rounded),
                          Text('Habillement'),
                        ],
                      ),
                      subtitle: LinearProgressIndicator(
                        color: Colors.red,
                        minHeight: 15,
                        value: percent_clothing_global / 100,
                      ),
                      trailing: Text('$total_clothing_global F CFA'),
                    ),
                  ),
                      Container(
                    margin: EdgeInsets.all(5),
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Row(
                        children: [
                          Icon(Icons.drive_eta),
                          Text('Deplacement'),
                        ],
                      ),
                      subtitle: LinearProgressIndicator(
                        color: Colors.red,
                        minHeight: 15,
                        value: percent_deplacement_global / 100,
                      ),
                      trailing: Text('$total_deplacement_global F CFA'),
                    ),
                  ),

                   Container(
                    margin: EdgeInsets.all(5),
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Row(
                        children: [
                          Icon(Icons.school),
                          Text('Education'),
                        ],
                      ),
                      subtitle: LinearProgressIndicator(
                        color: Colors.red,
                        minHeight: 15,
                        value: percent_education_global / 100,
                      ),
                      trailing: Text('$total_education_global F CFA'),
                    ),
                  ),
                   Container(
                    margin: EdgeInsets.all(5),
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Row(
                        children: [
                          Icon(Icons.miscellaneous_services),
                          Text('Divers'),
                        ],
                      ),
                      subtitle: LinearProgressIndicator(
                        color: Colors.red,
                        minHeight: 15,
                        value: percent_divers_global / 100,
                      ),
                      trailing: Text('$total_divers_global F CFA'),
                    ),
                  ),

              
                ],
              )),
        )));
  }
}
