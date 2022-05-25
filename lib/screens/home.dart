import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gestion_buget_apps/screens/acceuil.dart';
import 'package:gestion_buget_apps/screens/statistique.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectIndex = 0;

  List<Widget> screens = [AcceuilScreen(), StatistiqueScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       DropdownButton(
      //         value: mois1,
      //         items: mois.map((String item) {
      //           return DropdownMenuItem(
      //             value: item,
      //             child: Text(item),
      //           );
      //         }).toList(),
      //         onChanged: (String? newValue) {
      //           setState(() {
      //             mois1 = newValue!;
      //             readCompte();

      //             print('Val: ${mois1}');
      //           });
      //         },
      //       ),
      //       Text('Gestion Budget'),
      //       IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
      //     ],
      //   ),
      // ),
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
          Navigator.pushNamed(context, 'compte_form');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
