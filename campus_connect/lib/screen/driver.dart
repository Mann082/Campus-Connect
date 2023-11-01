import 'package:campus_connect/screen/authscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:campus_connect/screen/login.dart';

class driverHome extends StatefulWidget {
  const driverHome({super.key});
  static const routeName = "/driverHome";

  @override
  State<driverHome> createState() => _driverHomeState();
}

class _driverHomeState extends State<driverHome> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var selectedBus = "Select Bus";
    var _buses = [
      "Bus 1",
      "Bus 2",
      "Bus 3",
      "Bus 4",
      "Bus 5",
      "Bus 6",
      "Bus 7",
      "Bus 1",
      "Bus 2",
      "Bus 3",
      "Bus 4",
      "Bus 5",
      "Bus 6",
      "Bus 7",
      "Bus 1",
      "Bus 2",
      "Bus 3",
      "Bus 4",
      "Bus 5",
      "Bus 6",
      "Bus 7",
      "Bus 1",
      "Bus 2",
      "Bus 3",
      "Bus 4",
      "Bus 5",
      "Bus 6",
      "Bus 7"
    ];
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: TextStyle(
            color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 30),
        //foregroundColor: Colors.amber,
        backgroundColor: Color.fromARGB(255, 159, 239, 255),
        title: Text("Driver Screen"),
      ),
      drawer: Drawer(
          child: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top),
            Container(
              width: 300,
              height: 100,
              color: Color.fromARGB(195, 99, 255, 229),
              child: Text(
                "Hii Driver",
                style: TextStyle(
                  fontSize: 40,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            ElevatedButton(
              child: Text("Logout"),
              style: TextButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 255, 255, 255),
                  minimumSize: Size(150, 40)),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => authScreen(),
                ));
              },
            ),
          ],
        ),
      )),
      body: Container(
        padding: EdgeInsets.all(50),
        child: Center(
          child: Column(
            children: [
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: Column(children: [
                  SizedBox(height: 20),
                  Center(
                    child: Card(
                      elevation: 7,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(33)),
                      child: Container(
                        height: size.height * 0.3,
                        width: MediaQuery.of(context).size.width * 0.95,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color.fromARGB(255, 11, 223, 156)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: size.height * 0.03,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white),
                              child: DropdownMenu(
                                  inputDecorationTheme: InputDecorationTheme(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                              width: 10, color: Colors.black))),
                                  width: size.width * 0.85,
                                  hintText: "Select Bus",
                                  leadingIcon: Icon(CupertinoIcons.bus),
                                  initialSelection: "Please Select",
                                  menuStyle: MenuStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.white),
                                      shadowColor: MaterialStatePropertyAll(
                                          Colors.white),
                                      fixedSize: MaterialStatePropertyAll(Size(
                                          size.width * 0.5, size.height * 0.5)),
                                      shape: MaterialStatePropertyAll(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              side: BorderSide(
                                                  color: Colors.grey,
                                                  width: 2)))),
                                  onSelected: (String? value) {
                                    setState(() {
                                      // print("presssed");
                                      // selectedContact = value!;
                                      // contacts = Provider.of<Groups>(context, listen: false)
                                      //     .returnByName(value.toString());
                                      selectedBus = value!;
                                      print(value);
                                    });
                                  },
                                  // width: double.maxFinite,
                                  dropdownMenuEntries: _buses
                                      .map((e) => DropdownMenuEntry(
                                          value: e,
                                          label: e,
                                          leadingIcon: Icon(CupertinoIcons.bus),
                                          style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.white))))
                                      .toList()),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text('Selected Bus : $selectedBus'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Start",
                  style: TextStyle(
                      color: Colors.amber,
                      fontSize: 40,
                      fontStyle: FontStyle.italic),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(120, 130),
                  backgroundColor: Colors.red,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Stop",
                  style: TextStyle(
                      color: Colors.amber,
                      fontSize: 40,
                      fontStyle: FontStyle.italic),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(120, 130),
                  backgroundColor: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
