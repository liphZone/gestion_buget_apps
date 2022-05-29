import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gestion_buget_apps/screens/acceuil.dart';
import 'package:gestion_buget_apps/screens/statistique.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectIndex = 0;

  List<Widget> screens = [AcceuilScreen(), StatistiqueScreen()];

  var data_global;

  Future updateCompte() async {
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
    updateCompte();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens.elementAt(selectIndex),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 5,
        elevation: 10,
        clipBehavior: Clip.antiAlias,
        shape: CircularNotchedRectangle(),
        child: BottomNavigationBar(
          currentIndex: selectIndex,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.black,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.analytics), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: ''),
          ],
          onTap: (val) {
            setState(() {
              selectIndex = val;
            });
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          data_global == false
              ? Navigator.pushNamed(context, 'compte_form')
              : Navigator.pushNamed(context, 'compte_update');
        },
        child: data_global == false ? Icon(Icons.add) : Icon(Icons.edit),
      ),
    );
  }
}
