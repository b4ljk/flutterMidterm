import 'package:flutter/material.dart';

import 'package:flutterfire_ui/auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class myProfileScreen extends StatefulWidget {
  const myProfileScreen({Key? key}) : super(key: key);

  @override
  State<myProfileScreen> createState() => _myProfileScreenState();
}

class _myProfileScreenState extends State<myProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(vertical: 60, horizontal: 15),
      child: ProfileScreen(
        children: [
          OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const FaIcon(FontAwesomeIcons.arrowLeft,
                      color: Colors.white, size: 24),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Back"),
                ],
              ))
        ],
        providerConfigs: [],
        avatarSize: 100,
      ),
    ));
  }
}
