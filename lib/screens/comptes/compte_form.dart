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

  int index = -1;

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
      date: DateTime.now(),
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
                              logement == true
                                  ? Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: montantLogementController,
                                        decoration: InputDecoration(
                                            hintText: 'Montant logement',
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15))),
                                      ),
                                    )
                                  : SizedBox(),
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
                              SizedBox(),
                              alimentation == true
                                  ? Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller:
                                            montantAlimentationController,
                                        decoration: InputDecoration(
                                            hintText: 'Montant',
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15))),
                                      ),
                                    )
                                  : SizedBox(),
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
                              SizedBox(),
                              habillement == true
                                  ? Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller:
                                            montantHabillementController,
                                        decoration: InputDecoration(
                                            hintText: 'Montant habillement',
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15))),
                                      ),
                                    )
                                  : SizedBox(),
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
                              SizedBox(),
                              deplacement == true
                                  ? Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller:
                                            montantDeplacementController,
                                        decoration: InputDecoration(
                                            hintText: 'Montant deplacement',
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15))),
                                      ),
                                    )
                                  : SizedBox(),
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
                              SizedBox(),
                              education == true
                                  ? Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: montantEducationController,
                                        decoration: InputDecoration(
                                            hintText: 'Montant Education',
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15))),
                                      ),
                                    )
                                  : SizedBox(),
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
                              divers == true
                                  ? Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: montantDiversController,
                                        decoration: InputDecoration(
                                            hintText: 'Montant divers',
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15))),
                                      ),
                                    )
                                  : SizedBox(
                                      height: 10,
                                    ),
                            ],
                          ),
                          isExpanded: index == 2,
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      addCompte();
                    },
                    child: Text('Enregistrer')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Retour',
                    ))
              ],
            ),
          ),
        )),
      ),
    );
  }
}
