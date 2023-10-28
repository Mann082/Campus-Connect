import 'package:campus_connect/screen/authscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:campus_connect/screen/login.dart';

class driverScreen extends StatelessWidget {
  const driverScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  DropdownMenu(
                      width: 350,
                      hintText: "select Bus",
                      initialSelection: "select bus",
                      menuStyle: const MenuStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.white),
                          shadowColor: MaterialStatePropertyAll(Colors.white)),
                      onSelected: (value) {},
                      dropdownMenuEntries: [])
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
