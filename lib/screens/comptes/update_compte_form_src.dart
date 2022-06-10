import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../home.dart';

class CompteUpdateScreen extends StatefulWidget {
  const CompteUpdateScreen({Key? key}) : super(key: key);

  @override
  State<CompteUpdateScreen> createState() => _CompteUpdateScreenState();
}

class _CompteUpdateScreenState extends State<CompteUpdateScreen> {
  GlobalKey<FormState> updateCompteFormKey = GlobalKey();
  TextEditingController soldeController = TextEditingController();
  TextEditingController logementController = TextEditingController();
  TextEditingController foodController = TextEditingController();
  TextEditingController habillementController = TextEditingController();
  TextEditingController deplacementController = TextEditingController();
  TextEditingController educationController = TextEditingController();
  TextEditingController diversController = TextEditingController();

  // Lecture des donnees de la base concernant les donnees saisies au jour actuel
  Future todayData() async {
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
        for (var counter = 0; counter < snapshot.docs.length; counter++) {
          total_solde += snapshot.docs[counter]['solde'];
          total_logement += snapshot.docs[counter]['montant_logement'];
          total_alimentation += snapshot.docs[counter]['montant_alimentation'];
          total_habillement += snapshot.docs[counter]['montant_habillement'];
          total_deplacement += snapshot.docs[counter]['montant_deplacement'];
          total_education += snapshot.docs[counter]['montant_education'];
          total_divers += snapshot.docs[counter]['montant_divers'];
        }

        setState(() {
          soldeController.text = '$total_solde';
          logementController.text = '$total_logement';
          foodController.text = '$total_alimentation';
          habillementController.text = '$total_habillement';
          deplacementController.text = '$total_deplacement';
          educationController.text = '$total_education';
          diversController.text = '$total_divers';
        });
      });
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Erreur $e')));
    }
  }

  Future updateCompte() async {
    try {
      //Recuperation de l'id du compte
      final updateCompte = FirebaseFirestore.instance
          .collection('comptes')
          .doc('Compte-${DateFormat("dd-MM-yyyy").format(DateTime.now())}');

      //Mise a jour des donnees
      updateCompte.update({
        'solde': double.parse(soldeController.text),
        'montant_logement': double.parse(logementController.text),
        'montant_alimentation': double.parse(foodController.text),
        'montant_habillement': double.parse(habillementController.text),
        'montant_deplacement': double.parse(deplacementController.text),
        'montant_education': double.parse(educationController.text),
        'montant_divers': double.parse(diversController.text),
      });

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (route) => false);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Vous avez effectuée une mise à jour de la dépense journalière ')));
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Erreur $e')));
    }
  }

  @override
  void initState() {
    todayData();
    super.initState();
  }

  @override
  void dispose() {
    todayData();
    super.dispose();
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
              decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(20)),
              child: Form(
                key: updateCompteFormKey,
                child: Column(
                  children: [
                    Text('Modification dépense du jour'),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.1,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: soldeController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          validator: (val) =>
                              val!.isEmpty ? 'Veuillez saisir le solde' : null,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.05,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Montant logement'),
                          Text('Montant nourriture'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.1,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            Expanded(
                                child: Container(
                              height: double.infinity,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: logementController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                                validator: (val) => val!.isEmpty
                                    ? 'Veuillez saisir le logement'
                                    : null,
                              ),
                            )),
                            SizedBox(
                              width: 2,
                            ),
                            Expanded(
                              child: Container(
                                height: double.infinity,
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: foodController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15))),
                                  validator: (val) => val!.isEmpty
                                      ? 'Veuillez saisir le montant de la nourriture'
                                      : null,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.05,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Montant habillement'),
                          Text('Montant déplacement'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.1,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            Expanded(
                                child: Container(
                              height: double.infinity,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: habillementController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                                validator: (val) => val!.isEmpty
                                    ? 'Veuillez saisir le montant habillement'
                                    : null,
                              ),
                            )),
                            SizedBox(
                              width: 2,
                            ),
                            Expanded(
                              child: Container(
                                height: double.infinity,
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: deplacementController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15))),
                                  validator: (val) => val!.isEmpty
                                      ? 'Veuillez saisir le montant déplacement'
                                      : null,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.05,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Montant éducation'),
                          Text('Montant divers'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.1,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            Expanded(
                                child: Container(
                              height: double.infinity,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: educationController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                                validator: (val) => val!.isEmpty
                                    ? 'Veuillez saisir le montant éducation'
                                    : null,
                              ),
                            )),
                            SizedBox(
                              width: 2,
                            ),
                            Expanded(
                              child: Container(
                                height: double.infinity,
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: diversController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15))),
                                  validator: (val) => val!.isEmpty
                                      ? 'Veuillez saisir le montant divers'
                                      : null,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (updateCompteFormKey.currentState!.validate()) {
                            updateCompte();
                          }
                        },
                        child: Text('Modifier')),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
