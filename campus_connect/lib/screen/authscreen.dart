import 'package:campus_connect/screen/login.dart';
import 'package:campus_connect/screen/signup.dart';
import 'package:flutter/material.dart';

class authScreen extends StatefulWidget {
  const authScreen({super.key});
  static const routeName = "/authscreen";
  @override
  State<authScreen> createState() => _authScreenState();
}

class _authScreenState extends State<authScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 206, 255, 250),
          appBar: AppBar(
              title: Text(
                "Campus Connect",
                style: TextStyle(fontSize: 30),
              ),
              bottom: const TabBar(
                // dividerColor: Colors.pink,
                labelStyle: TextStyle(fontSize: 15),
                tabs: [
                  Tab(
                    icon: Icon(Icons.login),
                    text: "Login",
                  ),
                  Tab(
                    icon: Icon(Icons.install_mobile),
                    text: "Signup",
                  ),
                ],
              )),
          body: TabBarView(
            children: [Login(), signup()],
          ),
        ));
  }
}
