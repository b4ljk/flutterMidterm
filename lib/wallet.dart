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
  int _depositIndex = 0;
  bool visibility = true;
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
                height: MediaQuery.of(context).size.height * 0.64,
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
                    const SizedBox(
                      height: 20,
                    ),
                    FlutterToggleTab(
                      width: MediaQuery.of(context).size.width * 0.23,
                      marginSelected: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
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
                          _initialIndex = index;
                          if (_initialIndex == 0) {
                            visibility = true;
                          } else {
                            visibility = false;
                          }
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Visibility(
                      visible: visibility,
                      child: Column(
                        children: [
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
                          Container(
                            height: 500,
                            child: ListView(
                              // shrinkWrap: true,
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: TextFormField(
                                    controller: cardNumberCtrl,
                                    decoration: const InputDecoration(
                                        hintText: 'Card Number'),
                                    maxLength: 16,
                                    onChanged: (value) {
                                      final newCardNumber = value.trim();
                                      var newStr = '';
                                      final step = 4;

                                      for (var i = 0;
                                          i < newCardNumber.length;
                                          i += step) {
                                        newStr += newCardNumber.substring(
                                            i,
                                            math.min(i + step,
                                                newCardNumber.length));
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
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: TextFormField(
                                    controller: expiryFieldCtrl,
                                    decoration: const InputDecoration(
                                        hintText: 'Card Expiry'),
                                    maxLength: 5,
                                    onChanged: (value) {
                                      var newDateValue = value.trim();
                                      final isPressingBackspace =
                                          expiryDate.length >
                                              newDateValue.length;
                                      final containsSlash =
                                          newDateValue.contains('/');

                                      if (newDateValue.length >= 2 &&
                                          !containsSlash &&
                                          !isPressingBackspace) {
                                        newDateValue =
                                            newDateValue.substring(0, 2) +
                                                '/' +
                                                newDateValue.substring(2);
                                      }
                                      setState(() {
                                        expiryFieldCtrl.text = newDateValue;
                                        expiryFieldCtrl.selection =
                                            TextSelection.fromPosition(
                                                TextPosition(
                                                    offset:
                                                        newDateValue.length));
                                        expiryDate = newDateValue;
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                        hintText: 'Card Holder Name'),
                                    onChanged: (value) {
                                      setState(() {
                                        cardHolderName = value;
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 25),
                                  child: TextFormField(
                                    decoration:
                                        const InputDecoration(hintText: 'CVV'),
                                    maxLength: 3,
                                    onChanged: (value) {
                                      setState(() {
                                        cvv = value;
                                      });
                                    },
                                    focusNode: _focusNode,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 125,
                                  ),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                const Color.fromARGB(
                                                    255, 212, 228, 209)),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ))),
                                    onPressed: () => {},
                                    child: const InkWell(
                                      onTap: null,
                                      child: SizedBox(
                                          width: 40,
                                          height: 50,
                                          child: Center(
                                              child: Text(
                                            "Pay",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 31, 117, 34),
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ))),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 300,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      //Bank info page
                      replacement: Column(children: [
                        InkWell(
                          onTap: () => {
                            setState(() {
                              _depositIndex = 0;
                              print(_depositIndex);
                            })
                          },
                          child: Container(
                              height: 110,
                              decoration: BoxDecoration(
                                  color: _depositIndex == 0
                                      ? Color.fromARGB(255, 237, 240, 236)
                                      : Color.fromARGB(179, 245, 243, 243),
                                  borderRadius: BorderRadius.circular(20)),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 20,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 60,
                                      width: 60,
                                      child: Center(
                                        child: FaIcon(FontAwesomeIcons.bank,
                                            color: _depositIndex == 0
                                                ? Colors.teal
                                                : Colors.blueGrey,
                                            size: 28),
                                      ),
                                      decoration: new BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.04,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Bank Link",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: _depositIndex == 0
                                                ? Colors.teal
                                                : Colors.blueGrey,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'Connect your bank',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: _depositIndex == 0
                                                  ? Colors.teal
                                                  : Colors.blueGrey,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          'account to depsit & fund',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: _depositIndex == 0
                                                  ? Colors.teal
                                                  : Colors.blueGrey,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.14,
                                    ),
                                    _depositIndex == 0
                                        ? Container(
                                            height: 30,
                                            width: 30,
                                            child: const Center(
                                              child: FaIcon(
                                                FontAwesomeIcons.check,
                                                size: 17,
                                                color: Colors.white,
                                              ),
                                            ),
                                            decoration: new BoxDecoration(
                                              color: Colors.teal,
                                              shape: BoxShape.circle,
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () => {
                            setState(() {
                              _depositIndex = 1;
                              print(_depositIndex);
                            })
                          },
                          child: Container(
                              height: 110,
                              decoration: BoxDecoration(
                                  color: _depositIndex == 1
                                      ? Color.fromARGB(255, 237, 240, 236)
                                      : Color.fromARGB(179, 245, 243, 243),
                                  borderRadius: BorderRadius.circular(20)),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 20,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 60,
                                      width: 60,
                                      child: Center(
                                        child: FaIcon(FontAwesomeIcons.bank,
                                            color: _depositIndex == 1
                                                ? Colors.teal
                                                : Colors.blueGrey,
                                            size: 28),
                                      ),
                                      decoration: new BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.04,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Bank Link",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: _depositIndex == 1
                                                ? Colors.teal
                                                : Colors.blueGrey,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'Connect your bank',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: _depositIndex == 1
                                                  ? Colors.teal
                                                  : Colors.blueGrey,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          'account to depsit & fund',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: _depositIndex == 1
                                                  ? Colors.teal
                                                  : Colors.blueGrey,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.14,
                                    ),
                                    _depositIndex == 1
                                        ? Container(
                                            height: 30,
                                            width: 30,
                                            child: const Center(
                                              child: FaIcon(
                                                FontAwesomeIcons.check,
                                                size: 17,
                                                color: Colors.white,
                                              ),
                                            ),
                                            decoration: new BoxDecoration(
                                              color: Colors.teal,
                                              shape: BoxShape.circle,
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () => {
                            setState(() {
                              _depositIndex = 2;
                              print(_depositIndex);
                            })
                          },
                          child: Container(
                              height: 110,
                              decoration: BoxDecoration(
                                  color: _depositIndex == 2
                                      ? Color.fromARGB(255, 237, 240, 236)
                                      : Color.fromARGB(179, 245, 243, 243),
                                  borderRadius: BorderRadius.circular(20)),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 20,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 60,
                                      width: 60,
                                      child: Center(
                                        child: FaIcon(FontAwesomeIcons.bank,
                                            color: _depositIndex == 2
                                                ? Colors.teal
                                                : Colors.blueGrey,
                                            size: 28),
                                      ),
                                      decoration: new BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.04,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Bank Link",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: _depositIndex == 2
                                                ? Colors.teal
                                                : Colors.blueGrey,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'Connect your bank',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: _depositIndex == 2
                                                  ? Colors.teal
                                                  : Colors.blueGrey,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          'account to depsit & fund',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: _depositIndex == 2
                                                  ? Colors.teal
                                                  : Colors.blueGrey,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.14,
                                    ),
                                    _depositIndex == 2
                                        ? Container(
                                            height: 30,
                                            width: 30,
                                            child: const Center(
                                              child: FaIcon(
                                                FontAwesomeIcons.check,
                                                size: 17,
                                                color: Colors.white,
                                              ),
                                            ),
                                            decoration: new BoxDecoration(
                                              color: Colors.teal,
                                              shape: BoxShape.circle,
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              )),
                        ),
                      ]),
                    ),
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
