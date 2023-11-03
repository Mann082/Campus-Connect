import 'package:campus_connect/providers/bus_data.dart';
import 'package:campus_connect/screen/drivercontrols.dart';
import 'package:campus_connect/widgets/buttom.dart';
import 'package:campus_connect/widgets/mainDrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class driverHome extends StatefulWidget {
  static const routeName = "/driverHome";
  const driverHome({super.key});

  @override
  State<driverHome> createState() => _driverHomeState();
}

class _driverHomeState extends State<driverHome> {
  var selectedBus = "Select Bus";
  var _buses = ["Dummy"];

  Future<void> _fetchAndSetBus() async {
    await Provider.of<Buses>(context, listen: false).fetchBuses();
    _buses = Provider.of<Buses>(context, listen: false).busList;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select Bus',
          textAlign: TextAlign.center,
        ),
      ),
      drawer: mainDrawer(
        title: "Driver",
      ),
      body: FutureBuilder(
        future: _fetchAndSetBus(),
        builder: (context, snapshot) => (snapshot.connectionState ==
                ConnectionState.waiting)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.2,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      child: DropdownMenu(
                          inputDecorationTheme: InputDecorationTheme(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      width: 10, color: Colors.black))),
                          width: size.width * 0.85,
                          hintText: selectedBus,
                          leadingIcon: const Icon(CupertinoIcons.bus),
                          initialSelection: "Please Select",
                          menuStyle: MenuStyle(
                              backgroundColor:
                                  const MaterialStatePropertyAll(Colors.white),
                              shadowColor:
                                  const MaterialStatePropertyAll(Colors.white),
                              maximumSize: MaterialStatePropertyAll(
                                  Size.fromHeight(size.height * 0.5)),
                              // fixedSize: MaterialStatePropertyAll(
                              //     Size.fromWidth(size.width * 0.5)),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: const BorderSide(
                                          color: Colors.grey, width: 2)))),
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
                                  leadingIcon: const Icon(CupertinoIcons.bus),
                                  style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.white))))
                              .toList()),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text('Selected Bus : $selectedBus'),
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Provider.of<Buses>(context, listen: false)
                              .setBus(selectedBus);
                          Navigator.of(context)
                              .pushNamed(driverControlsScreen.routeName);
                        },
                        child: const Text(
                          'Confirm',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size.fromWidth(size.width * 0.85),
                            backgroundColor: Color.fromARGB(255, 67, 205, 154),
                            elevation: 10,
                            foregroundColor: Colors.white))
                  ],
                ),
              ),
      ),
    );
  }
}
