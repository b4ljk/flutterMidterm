//Readdata
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:awesome_card/awesome_card.dart';
import 'dart:math' as math;
import 'package:fluttertoast/fluttertoast.dart';

class Readdata extends StatefulWidget {
  const Readdata({Key? key}) : super(key: key);

  @override
  State<Readdata> createState() => _ReaddataState();
}

class _ReaddataState extends State<Readdata> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print(index);
      // if (index == 0) {
      //   Navigator.pushNamed(context, '/');
      // }
      // if (index == 3) {
      //   Navigator.pushNamed(context, '/wallet');
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          //set background image
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg1.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      )),
                  const Text(
                    "Wallet",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.notifications,
                        color: Colors.white,
                      )),
                ],
              ),
              const SizedBox(
                height: 70,
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.70,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(children: [
                    ///////////////
                  ]),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.home, size: 36),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.barsProgress, size: 36),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.wallet, size: 36),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.user, size: 36),
              label: '',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.teal,
          unselectedItemColor: Colors.black12,
          onTap: _onItemTapped,
        ));
  }
}
