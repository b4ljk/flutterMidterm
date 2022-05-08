//wallet screen
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:awesome_card/awesome_card.dart';
import 'dart:math' as math;

class wallet extends StatefulWidget {
  const wallet({Key? key}) : super(key: key);

  @override
  State<wallet> createState() => _walletState();
}

class _walletState extends State<wallet> {
  int _selectedIndex = 0;
  int _initialIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String cardNumber = '';
  String cardHolderName = '';
  String expiryDate = '';
  String cvv = '';
  bool showBack = false;

  late FocusNode _focusNode;
  TextEditingController cardNumberCtrl = TextEditingController();
  TextEditingController expiryFieldCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _focusNode.hasFocus ? showBack = true : showBack = false;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
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
                height: 593,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(children: [
                  SizedBox(
                    height: 20,
                  ),
                  FlutterToggleTab(
                    width: MediaQuery.of(context).size.width * 0.23,
                    marginSelected:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    borderRadius: 30,
                    selectedBackgroundColors: [Colors.white70],
                    selectedTextStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                    unSelectedTextStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                    labels: const ["Cards", "Accounts"],
                    selectedIndex: _initialIndex,
                    selectedLabelIndex: (index) {
                      setState(() {
                        //   if (index == 0) {
                        //     Title = title1;
                        //     sub = sub1;
                        //     myicon = icon1;
                        //     price = price1;
                        //   } else {
                        //     Title = title2;
                        //     sub = sub2;
                        //     myicon = icon2;
                        //   }
                        _initialIndex = index;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CreditCard(
                      cardNumber: cardNumber,
                      cardExpiry: expiryDate,
                      cardHolderName: cardHolderName,
                      cvv: cvv,
                      bankName: "Golomt Bank",
                      cardType: CardType
                          .masterCard, // Optional if you want to override Card Type
                      showBackSide: showBack,
                      frontBackground: CardBackgrounds.black,
                      backBackground: CardBackgrounds.white,
                      showShadow: true,
                      textExpDate: 'Exp. Date',
                      textName: 'Card Holder Name',
                      textExpiry: 'MM/YY'),
                  ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: TextFormField(
                          controller: cardNumberCtrl,
                          decoration: InputDecoration(hintText: 'Card Number'),
                          maxLength: 16,
                          onChanged: (value) {
                            final newCardNumber = value.trim();
                            var newStr = '';
                            final step = 4;

                            for (var i = 0;
                                i < newCardNumber.length;
                                i += step) {
                              newStr += newCardNumber.substring(
                                  i, math.min(i + step, newCardNumber.length));
                              if (i + step < newCardNumber.length)
                                newStr += ' ';
                            }

                            setState(() {
                              cardNumber = newStr;
                            });
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: TextFormField(
                          controller: expiryFieldCtrl,
                          decoration: InputDecoration(hintText: 'Card Expiry'),
                          maxLength: 5,
                          onChanged: (value) {
                            var newDateValue = value.trim();
                            final isPressingBackspace =
                                expiryDate.length > newDateValue.length;
                            final containsSlash = newDateValue.contains('/');

                            if (newDateValue.length >= 2 &&
                                !containsSlash &&
                                !isPressingBackspace) {
                              newDateValue = newDateValue.substring(0, 2) +
                                  '/' +
                                  newDateValue.substring(2);
                            }
                            setState(() {
                              expiryFieldCtrl.text = newDateValue;
                              expiryFieldCtrl.selection =
                                  TextSelection.fromPosition(TextPosition(
                                      offset: newDateValue.length));
                              expiryDate = newDateValue;
                            });
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: TextFormField(
                          decoration:
                              InputDecoration(hintText: 'Card Holder Name'),
                          onChanged: (value) {
                            setState(() {
                              cardHolderName = value;
                            });
                          },
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                        child: TextFormField(
                          decoration: InputDecoration(hintText: 'CVV'),
                          maxLength: 3,
                          onChanged: (value) {
                            setState(() {
                              cvv = value;
                            });
                          },
                          focusNode: _focusNode,
                        ),
                      ),
                    ],
                  )
                ]),
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
