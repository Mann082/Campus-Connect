import 'package:campus_connect/screen/adminScreen.dart';
import 'package:campus_connect/screen/authscreen.dart';
import 'package:campus_connect/screen/driver.dart';
import 'package:campus_connect/screen/homepage.dart';
import 'package:flutter/material.dart';

class selectUserScreen extends StatelessWidget {
  static const routeName = "/setectuserscreen";

  const selectUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Select Your Role ",
          ),
        ),
        elevation: 10,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(authScreen.routeName);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 67, 205, 154),
                        ),
                        child: Image.asset(
                          'assets/student.png',
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    'Student',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(driverHome.routeName);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        width: 150,
                        height: 150,
                        color: Color.fromARGB(255, 67, 205, 154),
                        child: Image.asset('assets/driver.png',
                            fit: BoxFit.contain),
                      ),
                    ),
                  ),
                  const Text(
                    'Driver',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(adminScreen.routeName);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        width: 150,
                        height: 150,
                        color: Color.fromARGB(255, 67, 205, 154),
                        child: Image.asset('assets/admin.png',
                            fit: BoxFit.contain),
                      ),
                    ),
                  ),
                  const Text(
                    'Admin',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ]),
      ),
    );
  }
}
