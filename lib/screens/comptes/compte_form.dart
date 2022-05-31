import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestion_buget_apps/models/compte.dart';
import 'package:intl/intl.dart';

import '../home.dart';

class CompteFormScreen extends StatefulWidget {
  const CompteFormScreen({Key? key}) : super(key: key);

  @override
  State<CompteFormScreen> createState() => _CompteFormScreenState();
}

class _CompteFormScreenState extends State<CompteFormScreen> {
  GlobalKey<FormState> compteFormKey = GlobalKey();
  TextEditingController soldeController = TextEditingController();
  TextEditingController montantLogementController = TextEditingController();
  TextEditingController montantAlimentationController = TextEditingController();
  TextEditingController montantHabillementController = TextEditingController();
  TextEditingController montantDeplacementController = TextEditingController();
  TextEditingController montantEducationController = TextEditingController();
  TextEditingController montantDiversController = TextEditingController();

  int index = -1;

  Future addCompte() async {
    try {
      final docCompte = FirebaseFirestore.instance
          .collection('comptes')
          .doc('Compte-${DateFormat("dd-MM-yyyy").format(DateTime.now())}');

      final add_compte = Compte(
        jour: DateTime.now().day,
        mois: DateFormat.LLLL().format(DateTime.now()),
        solde: double.parse(soldeController.text),
        // logement: logement,
        montant_logement: double.parse(montantLogementController.text),
        // alimentation: alimentation,
        montant_alimentation: double.parse(montantAlimentationController.text),
        // habillement: habillement,
        montant_habillement: double.parse(montantHabillementController.text),
        // deplacement: deplacement,
        montant_deplacement: double.parse(montantDeplacementController.text),
        // education: education,
        montant_education: double.parse(montantEducationController.text),
        // divers: divers,
        montant_divers: double.parse(montantDiversController.text),
        date_complete: DateTime.now(),
        date: DateFormat("dd MM yyyy").format(DateTime.now()),
      );

      final json = add_compte.createCompteToJson();

      print('Solde : ${soldeController.text}');
      print('Logement : ${montantLogementController.text}');
      print('Food : ${montantAlimentationController.text}');


      // //creation du document et ecriture des datas
      await docCompte.set(json);

        Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                              (route) => false);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Vous avez enregistré une dépense journalière ')));

      soldeController.clear();
      montantLogementController.clear();
      montantAlimentationController.clear();
      montantHabillementController.clear();
      montantDeplacementController.clear();
      montantEducationController.clear();
      montantDiversController.clear();
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Erreur $e')));
    }
  }

  var data_global;

  // Verification de l'exisitance de l'id dans la base de données
  Future compteIdCheck() async {
    DocumentSnapshot documentSnapshot;
    try {
      documentSnapshot = await FirebaseFirestore.instance
          .collection('comptes')
          .doc('Compte-${DateFormat("dd-MM-yyyy").format(DateTime.now())}')
          .get();

      setState(() {
        data_global = documentSnapshot.exists;
      });

      print('Data : $documentSnapshot');
      print('Val : ${documentSnapshot.exists}');
    } on FirebaseException catch (e) {
      print(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Erreur $e')));
    }
  }

  @override
  void initState() {
    compteIdCheck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Container(
          margin: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.amber,
          child: Form(
            key: compteFormKey,
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: soldeController,
                    decoration: InputDecoration(
                        hintText: 'Solde',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                    validator: (val) =>
                        val!.isEmpty ? 'Veuillez saisir un solde' : null,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: ExpansionPanelList(
                      expansionCallback: (i, isOpen) {
                        setState(() {
                          if (index == i)
                            index = -1;
                          else
                            index = i;
                        });
                      },
                      animationDuration: Duration(milliseconds: 900),
                      dividerColor: Colors.teal,
                      elevation: 2,
                      children: [
                        ExpansionPanel(
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            return ListTile(
                              leading: Icon(Icons.flash_on_rounded),
                              title: Text("Besoins primaires"),
                            );
                          },
                          canTapOnHeader: true,
                          body: Column(
                            children: [
                              Text('Logement'),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: montantLogementController,
                                  decoration: InputDecoration(
                                      hintText: 'Montant logement',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15))),
                                  validator: (val) => val!.isEmpty
                                      ? 'Veuillez saisir le montant logement'
                                      : null,
                                ),
                              ),
                              SizedBox(),
                              Text('Nourriture'),
                              SizedBox(),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: montantAlimentationController,
                                  decoration: InputDecoration(
                                      hintText: 'Saisir montant nourriture',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15))),
                                  validator: (val) => val!.isEmpty
                                      ? 'Veuillez saisir le montant nourriture'
                                      : null,
                                ),
                              )
                            ],
                          ),
                          isExpanded: index == 0,
                        ),
                        ExpansionPanel(
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            return ListTile(
                              leading: Icon(Icons.settings),
                              title: Text("Besoins secondaires"),
                            );
                          },
                          canTapOnHeader: true,
                          body: Column(
                            children: [
                              Text('Habillement'),
                              SizedBox(),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: montantHabillementController,
                                  decoration: InputDecoration(
                                      hintText: 'Montant habillement',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15))),
                                  validator: (val) => val!.isEmpty
                                      ? 'Veuillez saisir le montant habillement'
                                      : null,
                                ),
                              ),
                              SizedBox(),
                              Text('Dépalcement'),
                              SizedBox(),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: montantDeplacementController,
                                  decoration: InputDecoration(
                                      hintText: 'Montant déplacement',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15))),
                                  validator: (val) => val!.isEmpty
                                      ? 'Veuillez saisir le montant déplacement'
                                      : null,
                                ),
                              ),
                            ],
                          ),
                          isExpanded: index == 1,
                        ),
                        ExpansionPanel(
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            return ListTile(
                              leading: Icon(Icons.help),
                              title: Text("Autres besoins"),
                            );
                          },
                          canTapOnHeader: true,
                          body: Column(
                            children: [
                              Text('Education'),
                              SizedBox(),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: montantEducationController,
                                    decoration: InputDecoration(
                                        hintText: 'Montant Education',
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15))),
                                    validator: (val) => val!.isEmpty
                                        ? 'Veuillez saisir le montant éducation'
                                        : null),
                              ),
                              Text('Divers'),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: montantDiversController,
                                  decoration: InputDecoration(
                                      hintText: 'Montant divers',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15))),
                                  validator: (val) => val!.isEmpty
                                      ? 'Veuillez saisir le montant divers'
                                      : null,
                                ),
                              ),
                            ],
                          ),
                          isExpanded: index == 2,
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          if (compteFormKey.currentState!.validate()) {
                            addCompte();
                          }
                        },
                        child: Text('Enregistrer')),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                              (route) => false);
                        },
                        child: Text(
                          'Retour',
                        )),
                  ],
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
