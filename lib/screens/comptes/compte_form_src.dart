import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestion_buget_apps/models/compte_mdl.dart';
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
        mois_int: DateTime.now().month,
        solde: double.parse(soldeController.text),
        montant_logement: double.parse(montantLogementController.text),
        montant_alimentation: double.parse(montantAlimentationController.text),
        montant_habillement: double.parse(montantHabillementController.text),
        montant_deplacement: double.parse(montantDeplacementController.text),
        montant_education: double.parse(montantEducationController.text),
        montant_divers: double.parse(montantDiversController.text),
        date_complete: DateTime.now(),
        date: DateFormat("dd MM yyyy").format(DateTime.now()),
      );

      final json = add_compte.createCompteToJson();

      // //creation du document et ecriture des datas
      await docCompte.set(json);

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomeScreen()),
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
    } on FirebaseException catch (e) {
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
  void dispose() {
    compteIdCheck();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          margin: EdgeInsets.all(2),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [BoxShadow(blurRadius: 1)]),
          child: Form(
            key: compteFormKey,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top:5),
                  height: height * 0.1,
                  width: width,
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
                Container(
                  height: height * 0.1,
                  width: width,
                  child: Center(
                      child: Column(
                    children: [
                      Text('Besoins primaires'),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              child: Text('Logement'),
                            ),
                            Container(
                              child: Text('Nourriture'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
                ),
                Container(),
                Container(
                  margin: EdgeInsets.all(5),
                  height: height * 0.1,
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        height: double.infinity,
                        width: width * 0.5,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: montantLogementController,
                          decoration: InputDecoration(
                              hintText: 'Montant logement',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          validator: (val) => val!.isEmpty
                              ? 'Veuillez saisir le montant logement'
                              : null,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: double.infinity,
                          width: width * 0.5,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: montantAlimentationController,
                            decoration: InputDecoration(
                                hintText: 'Montant nourriture',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15))),
                            validator: (val) => val!.isEmpty
                                ? 'Veuillez saisir le montant nourriture'
                                : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  height: height * 0.1,
                  width: width,
                  child: Center(
                      child: Column(
                    children: [
                      Text('Besoins secondaires'),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              child: Text('Habillement'),
                            ),
                            Container(
                              child: Text('Déplacement'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  height: height * 0.1,
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        height: double.infinity,
                        width: width * 0.5,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: montantHabillementController,
                          decoration: InputDecoration(
                              hintText: 'Montant habillement',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          validator: (val) => val!.isEmpty
                              ? 'Veuillez saisir le montant habillement'
                              : null,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: double.infinity,
                          width: width * 0.5,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: montantDeplacementController,
                            decoration: InputDecoration(
                                hintText: 'Montant déplacement',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15))),
                            validator: (val) => val!.isEmpty
                                ? 'Veuillez saisir le montant déplacement'
                                : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  height: height * 0.1,
                  width: width,
                  child:Center(
                      child: Column(
                    children: [
                      Text('Autres Besoins'),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              child: Text('Education'),
                            ),
                            Container(
                              child: Text('Divers'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  height: height * 0.1,
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        height: double.infinity,
                        width: width * 0.5,
                        child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: montantEducationController,
                            decoration: InputDecoration(
                                hintText: 'Montant Education',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15))),
                            validator: (val) => val!.isEmpty
                                ? 'Veuillez saisir le montant éducation'
                                : null),
                      ),
                      Expanded(
                        child: Container(
                          height: double.infinity,
                          width: width * 0.5,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: montantDiversController,
                            decoration: InputDecoration(
                                hintText: 'Montant divers',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15))),
                            validator: (val) => val!.isEmpty
                                ? 'Veuillez saisir le montant divers'
                                : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  height: height * 0.1,
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        width: width * 0.5,
                        child: ElevatedButton(
                            onPressed: () {
                              if (compteFormKey.currentState!.validate()) {
                                addCompte();
                              }
                            },
                            child: Text('Enregistrer')),
                      ),
                      Expanded(
                        child: Container(
                          width: width * 0.5,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()),
                                    (route) => false);
                              },
                              child: Text(
                                'Retour',
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
