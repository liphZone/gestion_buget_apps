import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:gestion_buget_apps/screens/acceuil_src.dart';
import 'package:gestion_buget_apps/screens/budgets/mois_src.dart';
import 'package:gestion_buget_apps/screens/budgets/today_src.dart';
import 'package:gestion_buget_apps/screens/comptes/compte_form_src.dart';
import 'package:gestion_buget_apps/screens/comptes/update_compte_form_src.dart';
import 'package:gestion_buget_apps/screens/help_src.dart';
import 'package:gestion_buget_apps/screens/home.dart';
import 'package:gestion_buget_apps/screens/stats/chart_src.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestion Budget',
      theme: ThemeData(
     
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      initialRoute: 'home',
      routes: {
        'home'          : (context) => const HomeScreen(),
        'accueil'       : (context) => const AcceuilScreen(),
        'compte_form'   : (context) => const CompteFormScreen(),
        'compte_update' : (context) => const CompteUpdateScreen(),
        'today_depense' : (context) => const TodayOutlayScreen(),
        'month_depense' : (context) => const MonthOutlayScreen(),
        'stat_screen'   : (context) =>  const ChartScreen(),
        'help_screen'   : (context) =>  const HelpScreen(),
      },
    );
  }
}
