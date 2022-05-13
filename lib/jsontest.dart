//jsontest
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:awesome_card/awesome_card.dart';
import 'dart:math' as math;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'person.dart';
import 'person_network_service.dart';

class JsonTest extends StatefulWidget {
  const JsonTest({Key? key}) : super(key: key);

  @override
  State<JsonTest> createState() => _JsonTestState();
}

class _JsonTestState extends State<JsonTest> {
  final PersonNetworkService personService = PersonNetworkService();
  late Future<Album> futureAlbum;
  Future<Album> _Apicaller() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
    print(response.body);
    if (response.statusCode == 200) {
      print("OK");
      return Album.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  void initState() {
    super.initState();
    futureAlbum = _Apicaller();
  }

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
                child: Container(
                  height: 200,
                  child: SingleChildScrollView(
                    child: SafeArea(
                      child: FutureBuilder(
                        future: personService.fetchPersons(100),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Person>> snapshot) {
                          if (snapshot.hasData) {
                            return Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Card(
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: snapshot.data!.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                var currentPerson =
                                                    snapshot.data![index];

                                                return ListTile(
                                                  title:
                                                      Text(currentPerson.name),
                                                  leading: Container(
                                                    width: 70,
                                                    decoration:
                                                        new BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 185, 211, 208),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: const Center(
                                                      child: FaIcon(
                                                          FontAwesomeIcons.user,
                                                          color: Colors.teal,
                                                          size: 28),
                                                    ),
                                                  ),
                                                  subtitle: Text(
                                                      "Phone: ${currentPerson.phoneNumber}"),
                                                );
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }

                          if (snapshot.hasError) {
                            return const Center(
                                child: Icon(
                              Icons.error,
                              color: Colors.red,
                              size: 82.0,
                            ));
                          }

                          return Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const CircularProgressIndicator(),
                              const SizedBox(
                                height: 20.0,
                              ),
                              const Text(
                                  "Loading at the moment, please hold the line.")
                            ],
                          ));
                        },
                      ),
                    ),
                  ),
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

class Album {
  final int userId;
  final int id;
  final String title;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}
