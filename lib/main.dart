import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _initialIndex = 0;
  int _counter = 0;
  var title1 = ['Upwork', 'Transfer', 'Paypal'];
  var title2 = ['Electricity', 'House Rent', 'Spotify'];
  var sub1 = ['today', 'Yesterday', 'Jan 30, 2022'];
  var sub2 = ['Feb 28, 2022', 'Mar 28, 2022', 'Mar 31, 2022'];
  var sub = [];
  var Title = [];
  @override
  void initState() {
    Title = title1;
    sub = sub1;
    super.initState();
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
              height: 100,
            ),
            Container(
              width: double.infinity,
              height: 631,
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
                    const IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.add,
                          color: Colors.teal,
                          size: 40,
                        )),
                    const IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.qr_code,
                          color: Colors.teal,
                          size: 30,
                        )),
                    const IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.send,
                          color: Colors.teal,
                          size: 30,
                        )),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                FlutterToggleTab(
                  width: MediaQuery.of(context).size.width * 0.23,
                  marginSelected:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  borderRadius: 30,
                  selectedBackgroundColors: [Colors.white70],
                  selectedTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                  unSelectedTextStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                  labels: ["Transaction", "Upcoming bills"],
                  selectedIndex: _initialIndex,
                  selectedLabelIndex: (index) {
                    setState(() {
                      if (index == 0) {
                        Title = title1;
                        sub = sub1;
                      } else {
                        Title = title2;
                        sub = sub2;
                      }
                      _initialIndex = index;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: ListView.builder(
                    itemCount: Title.length,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: const Icon(Icons.ac_unit_rounded),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.20,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(Title[index].toString(),
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                    "Today",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                            const Text(
                              "+ \$ 8500.00",
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
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
    );
  }
}
