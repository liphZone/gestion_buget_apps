import 'package:flutter/material.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: PageView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.red,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "\r Gestion Budget est une application mobile dont le but est de gérer des dépenses journalières. \t Une interface explicite est fournie à l'utilisateur pour une utilisation facilité.",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                            "Les fonctionnalités disponibles sont les suivantes : ",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        Text(' - Ajout de dépense journalière',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        Text(' - Consulter la dépense journalière',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        Text(' - Consulter la dépense mensuelle',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        Text('- Consulter le graphe de dépense mensuelle',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Text(
                        'Glissez vers la droite pour passer à la page suivante ->')
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(blurRadius: 1)
                ]
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                        height: 50,
                        child: Text('- Ajout de dépense journalière ')),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                          'Sur la page accueil si dessous, il suffit de cliquer sur le bouton encerclé en rouge'),
                    ),
                    Container(
                      height: height * 0.55,
                      width: width,
                      child: Image.asset(
                        'assets/images/accueil_screen1.PNG',
                        height: 100,
                        width: 100,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          'Glissez vers la droite pour passer à la page suivante ->'),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                  boxShadow: [
                  BoxShadow(blurRadius: 1)
                ]
              ),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                        height: 50,
                        child: Text(
                            "Page d'enregistrement de dépense journalière")),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                          "ici vous remplissez le formulaire et le valider avec le bouton 'enregistrer' encerclé"),
                    ),
                    Container(
                      height: height * 0.55,
                      width: width,
                      child: Image.asset(
                        'assets/images/form_screen.PNG',
                        height: 100,
                        width: 100,
                        fit: BoxFit.fill,
                      ),
                    ),
                   Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          'Glissez vers la droite pour passer à la page suivante ->'),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                  boxShadow: [
                  BoxShadow(blurRadius: 1)
                ]
              ),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                        height: 50,
                        child: Text("- Consulter la dépense journalière")),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Il suffit de cliquez dans le cadre encerclé rouge"),
                    ),
                    Container(
                      height: height * 0.55,
                      width: width,
                      child: Image.asset(
                        'assets/images/accueil_screen2.png',
                        height: 100,
                        width: 100,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          'Glissez vers la droite pour passer à la page suivante ->'),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                  boxShadow: [
                  BoxShadow(blurRadius: 1)
                ]
              ),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                        height: 50, child: Text("Page dépense journalière")),
                    Container(
                      height: height * 0.55,
                      width: width,
                      child: Image.asset(
                        'assets/images/today_depense_screen.PNG',
                        height: 100,
                        width: 100,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          'Glissez vers la droite pour passer à la page suivante ->'),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                  boxShadow: [
                  BoxShadow(blurRadius: 1)
                ]
              ),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                        height: 50,
                        child: Text("- Consulter la dépense mensuelle")),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "Depuis la page d'accueil cliquez sur la partie encerclée"),
                    ),
                    Container(
                      height: height * 0.55,
                      width: width,
                      child: Image.asset(
                        'assets/images/accueil_screen3.png',
                        height: 100,
                        width: 100,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          'Glissez vers la droite pour passer à la page suivante ->'),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                  boxShadow: [
                  BoxShadow(blurRadius: 1)
                ]
              ),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                        height: 50, child: Text("Page la dépense mensuelle")),
                    Container(
                      height: height * 0.55,
                      width: width,
                      child: Image.asset(
                        'assets/images/month_depense_screen1.PNG',
                        height: 100,
                        width: 100,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          'Glissez vers la droite pour passer à la page suivante ->'),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                  boxShadow: [
                  BoxShadow(blurRadius: 1)
                ]
              ),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                        height: 50,
                        child: Text("- Depense mensuelle suivant le mois")),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Choisissez le mois dans la partie encerclée"),
                    ),
                    Container(
                      height: height * 0.55,
                      width: width,
                      child: Image.asset(
                        'assets/images/month_depense_screen2.png',
                        height: 100,
                        width: 100,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          'Glissez vers la droite pour passer à la page suivante ->'),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                  boxShadow: [
                  BoxShadow(blurRadius: 1)
                ]
              ),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                        height: 50,
                        child: Text("- Consulter le graphe mensuel")),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Choisissez le mois dans la partie encerclée"),
                    ),
                    Container(
                      height: height * 0.55,
                      width: width,
                      child: Image.asset(
                        'assets/images/accueil_screen4.png',
                        height: 100,
                        width: 100,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          'Glissez vers la droite pour passer à la page suivante ->'),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                  boxShadow: [
                  BoxShadow(blurRadius: 1)
                ]
              ),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 50, child: Text("Page graphe mensuel")),
                    Container(
                      height: height * 0.55,
                      width: width,
                      child: Image.asset(
                        'assets/images/graphe_screen.PNG',
                        height: 100,
                        width: 100,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Text('Fin')
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
