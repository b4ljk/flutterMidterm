import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'wallet.dart';
import 'jsontest.dart';
import 'globals.dart' as globals;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  print("firebae successfuully initiated");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const MyHomePage(title: 'Flutter Demo Home Page'),
        '/wallet': (context) => const wallet(),
        '/jsontest': (context) => const JsonTest(),
      },
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      initialRoute: '/',
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CollectionReference groceries =
      FirebaseFirestore.instance.collection('payment');
  int _initialIndex = 0;
  int _counter = 0;
  int _selectedIndex = 0;
  var title1 = ['Upwork', 'Transfer', 'Paypal'];
  var title2 = ['Electricity', 'Doctor bill', 'Spotify'];
  var sub1 = ['today', 'Yesterday', 'Jan 30, 2022'];
  var sub2 = ['Feb 28, 2022', 'Mar 28, 2022', 'Mar 31, 2022'];
  var price1 = [1200, -200, 3000];
  // var icon2 = ElevatedButton(onPressed: null, child: Text("pay"));

  var price = [];
  var sub = [];
  var Title = [];
  var icon1 = [
    const FaIcon(FontAwesomeIcons.umbrella, color: Colors.purple, size: 28),
    const FaIcon(FontAwesomeIcons.transgender, color: Colors.teal, size: 28),
    const FaIcon(FontAwesomeIcons.paypal, color: Colors.blue, size: 28)
  ];
  var icon2 = [
    const FaIcon(FontAwesomeIcons.bolt,
        color: Color.fromARGB(255, 209, 209, 5), size: 28),
    const FaIcon(FontAwesomeIcons.userDoctor, color: Colors.teal, size: 28),
    const FaIcon(FontAwesomeIcons.spotify, color: Colors.green, size: 28)
  ];

  var myicon = [];

  @override
  void initState() {
    Title = title1;
    sub = sub1;
    myicon = icon1;
    price = price1;
    super.initState();
    initialization();
  }

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
              children: const [
                IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    )),
                Text(
                  "Wallet",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                IconButton(
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
              child: Column(children: [
                const SizedBox(
                  height: 50,
                ),
                const Text("Total Balance"),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "\$ 2,548  ",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Container(
                      child: Center(
                        child: const IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.add,
                              color: Colors.teal,
                              size: 40,
                            )),
                      ),
                    ),
                    const IconButton(
                        onPressed: null,
                        icon: FaIcon(FontAwesomeIcons.qrcode,
                            color: Colors.teal, size: 28)),
                    const IconButton(
                        onPressed: null,
                        icon: FaIcon(FontAwesomeIcons.paperPlane,
                            color: Colors.teal, size: 25)),
                  ],
                ),
                const SizedBox(
                  height: 40,
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
                  labels: const ["Transaction", "Upcoming bills"],
                  selectedIndex: _initialIndex,
                  selectedLabelIndex: (index) {
                    setState(() {
                      if (index == 0) {
                        Title = title1;
                        sub = sub1;
                        myicon = icon1;
                        price = price1;
                      } else {
                        Title = title2;
                        sub = sub2;
                        myicon = icon2;
                      }
                      _initialIndex = index;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.37,
                  child: ListView.builder(
                    itemCount: Title.length,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            new BorderRadius.circular(10.0),
                                        color: const Color.fromARGB(
                                            31, 167, 162, 162)),
                                    child: Center(child: myicon[index])),
                                const SizedBox(
                                  width: 15,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.20,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(Title[index].toString(),
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                      const Text(
                                        "Today",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 12),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            _initialIndex == 0
                                ? Text(
                                    "${price[index]} \$",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: price[index] < 0
                                            ? Colors.red
                                            : Colors.green),
                                  )
                                : ElevatedButton(
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
                                    onPressed: () => {
                                      Navigator.pushNamed(context, '/wallet')
                                    },
                                    child: const InkWell(
                                      onTap: null,
                                      child: SizedBox(
                                          width: 40,
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
                                  )
                          ],
                        ),
                      );
                    }),
                  ),
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
      ),
    );
  }
}

void initialization() async {
  FlutterNativeSplash.remove();
}
