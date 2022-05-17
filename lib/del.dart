import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestion_buget_apps/models/compte.dart';

class CompteFormeScreen extends StatefulWidget {
  const CompteFormeScreen({Key? key}) : super(key: key);

  @override
  State<CompteFormeScreen> createState() => _CompteFormeScreenState();
}

class _CompteFormeScreenState extends State<CompteFormeScreen> {
  GlobalKey<FormState> compteFormKey = GlobalKey();
  TextEditingController soldeController = TextEditingController();
  TextEditingController montantLogementController = TextEditingController();
  TextEditingController montantAlimentationController = TextEditingController();
  TextEditingController montantHabillementController = TextEditingController();
  TextEditingController montantDeplacementController = TextEditingController();
  TextEditingController montantEducationController = TextEditingController();
  TextEditingController montantDiversController = TextEditingController();
  bool? logement = false;
  bool? alimentation = false;
  bool? habillement = false;
  bool? deplacement = false;
  bool? education = false;
  bool? divers = false;

  Future addCompte() async {
    final docCompte = FirebaseFirestore.instance.collection('comptes').doc();

    final add_compte = Compte(
      jour: DateTime.now().day,
      mois: DateTime.now().month,
      solde: int.parse(soldeController.text),
      logement: logement,
      montant_logement: int.parse(montantLogementController.text),
      alimentation: alimentation,
      montant_alimentation: int.parse(montantAlimentationController.text),
      habillement: habillement,
      montant_habillement: int.parse(montantHabillementController.text),
      deplacement: deplacement,
      montant_deplacement: int.parse(montantDeplacementController.text),
      education: education,
      montant_education: int.parse(montantHabillementController.text),
      divers: divers,
      montant_divers: int.parse(montantDiversController.text),
    );
    final json = add_compte.compteToJson();

    //creation du document et ecriture des datas
    await docCompte.set(json);
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
                TextFormField(
                  controller: soldeController,
                  decoration: InputDecoration(
                      hintText: 'Solde',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Besoins primaires',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  title: Text('Logement'),
                  leading: Checkbox(
                      value: logement,
                      onChanged: (value) {
                        setState(() {
                          logement = value;
                        });
                      }),
                ),
                SizedBox(
                  height: 10,
                ),
                logement == true
                    ? TextFormField(
                        keyboardType: TextInputType.number,
                        controller: montantLogementController,
                        decoration: InputDecoration(
                            hintText: 'Montant logement',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                      )
                    : SizedBox(
                        height: 5,
                      ),
                ListTile(
                  title: Text('Nourriture'),
                  leading: Checkbox(
                      value: alimentation,
                      onChanged: (value) {
                        setState(() {
                          alimentation = value;
                        });
                      }),
                ),
                SizedBox(
                  height: 10,
                ),
                alimentation == true
                    ? TextFormField(
                        keyboardType: TextInputType.number,
                        controller: montantAlimentationController,
                        decoration: InputDecoration(
                            hintText: 'Montant',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                      )
                    : SizedBox(
                        height: 10,
                      ),
                Text(
                  'Besoins secondaires',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  title: Text('Habillement'),
                  leading: Checkbox(
                      value: habillement,
                      onChanged: (value) {
                        setState(() {
                          habillement = value;
                        });
                      }),
                ),
                SizedBox(
                  height: 10,
                ),
                habillement == true
                    ? TextFormField(
                        keyboardType: TextInputType.number,
                        controller: montantHabillementController,
                        decoration: InputDecoration(
                            hintText: 'Montant habillement',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                      )
                    : SizedBox(
                        height: 10,
                      ),
                ListTile(
                  title: Text('Déplacement'),
                  leading: Checkbox(
                      value: deplacement,
                      onChanged: (value) {
                        setState(() {
                          deplacement = value;
                        });
                      }),
                ),
                SizedBox(
                  height: 10,
                ),
                deplacement == true
                    ? TextFormField(
                        keyboardType: TextInputType.number,
                        controller: montantDeplacementController,
                        decoration: InputDecoration(
                            hintText: 'Montant deplacement',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                      )
                    : SizedBox(
                        height: 10,
                      ),
                Text(
                  'Autres besoins',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                ListTile(
                  title: Text('Education'),
                  leading: Checkbox(
                      value: education,
                      onChanged: (value) {
                        setState(() {
                          education = value;
                        });
                      }),
                ),
                SizedBox(
                  height: 10,
                ),
                education == true
                    ? TextFormField(
                        keyboardType: TextInputType.number,
                        controller: montantEducationController,
                        decoration: InputDecoration(
                            hintText: 'Montant education',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                      )
                    : SizedBox(
                        height: 10,
                      ),
                ListTile(
                  title: Text('Divers'),
                  leading: Checkbox(
                      value: divers,
                      onChanged: (value) {
                        setState(() {
                          divers = value;
                        });
                      }),
                ),
                SizedBox(
                  height: 10,
                ),
                divers == true
                    ? TextFormField(
                        keyboardType: TextInputType.number,
                        controller: montantDiversController,
                        decoration: InputDecoration(
                            hintText: 'Montant divers',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                      )
                    : SizedBox(
                        height: 10,
                      ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      addCompte();
                    },
                    child: Text('Enregistrer'))
              ],
            ),
          ),
        )),
      ),
    );
  }
}
