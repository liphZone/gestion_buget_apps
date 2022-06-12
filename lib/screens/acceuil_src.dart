import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AcceuilScreen extends StatefulWidget {
  const AcceuilScreen({Key? key}) : super(key: key);

  @override
  State<AcceuilScreen> createState() => _AcceuilScreenState();
}

class _AcceuilScreenState extends State<AcceuilScreen> {
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
  double total_depense_global = 0;
  double total_reste_global = 0;
  double montant_food_today = 0;
  double montant_logement_today = 0;
  double total_food_global = 0;
  double total_logement_global = 0;

  //Je recupere les depenses individuellement suivant le mois
  Future readCompte() async {
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
          total_depense_global = total_depense;
          total_reste_global = total_reste;
          total_food_global = total_alimentation;
          total_logement_global = total_logement;
        });
      });
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Erreur $e')));
    }
  }

  //Affichage du montant des besoins d'aujourd'hui
  Future todayMontant() async {
    try {
      await FirebaseFirestore.instance
          .collection('comptes')
          .where('date',
              isEqualTo: DateFormat("dd MM yyyy").format(DateTime.now()))
          .get()
          .then((snapshot) {
        double total_logement = 0.0;
        double total_alimentation = 0.0;
        double total_habillement = 0.0;
        double total_deplacement = 0.0;
        double total_education = 0.0;
        double total_divers = 0.0;
        for (var counter = 0; counter < snapshot.docs.length; counter++) {
          total_logement += snapshot.docs[counter]['montant_logement'];
          total_alimentation += snapshot.docs[counter]['montant_alimentation'];
          total_habillement += snapshot.docs[counter]['montant_habillement'];
          total_deplacement += snapshot.docs[counter]['montant_deplacement'];
          total_education += snapshot.docs[counter]['montant_education'];
          total_divers += snapshot.docs[counter]['montant_divers'];
        }

        setState(() {
          montant_food_today = total_alimentation;
          montant_logement_today = total_logement;
        });
      });
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
    readCompte();
    todayMontant();
    super.initState();
  }

  @override
  void dispose() {
    readCompte();
    todayMontant();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  readCompte();
                });
              },
            ),
            Text('Gestion Budget'),
            // IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                    child: Column(
                      children: [
                        Icon(Icons.miscellaneous_services),
                        Text('Parametre'),
                      ],
                    ),
                    value: 'Poster'),
                PopupMenuItem(child: Text('Aide'), value: 'Poster'),
              ],
              onSelected: (val) {
                if (val == 'Poster') {
                  Navigator.pushNamed(context, 'help_screen');
                }
              },
            )
          ],
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white24,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.2,
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 1,
                        )
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Solde',
                            style: TextStyle(fontSize: 30),
                          ),
                          Text('$total_solde_global F CFA')
                        ],
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.account_balance_wallet_rounded,
                            size: 50,
                          ))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                        height: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.yellowAccent,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 1,
                              )
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'Dépenses',
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text('$total_depense_global F CFA')
                              ],
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.money_sharp,
                                  size: 50,
                                ))
                          ],
                        ),
                      )),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 1,
                                )
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'Reste',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(' $total_reste_global F CFA')
                                ],
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.money_off,
                                    size: 20,
                                  ))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'today_depense');
                  },
                  child: Container(
                    margin:
                        EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [BoxShadow(blurRadius: 4)]),
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: Center(
                              child: Text(
                                  "Aujourd'hui ${DateFormat("dd-MM-yyyy").format(DateTime.now())}")),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.restaurant_menu_rounded),
                                  Text('Nourriture'),
                                ],
                              ),
                              Text('$montant_food_today F CFA')
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.house_outlined),
                                  Text('Logement'),
                                ],
                              ),
                              Text('$montant_logement_today F CFA')
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'month_depense');
                  },
                  child: Container(
                    margin:
                        EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [BoxShadow(blurRadius: 4)]),
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: Center(child: Text("Mois actuel")),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.restaurant_menu_rounded),
                                  Text('Nourriture'),
                                ],
                              ),
                              Text('$total_food_global F CFA')
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.house_outlined),
                                  Text('Logement'),
                                ],
                              ),
                              Text('$total_logement_global F CFA')
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
