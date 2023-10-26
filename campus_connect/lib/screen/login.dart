import 'package:campus_connect/screen/homepage.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> _formkey = GlobalKey();

  var _usernameController = TextEditingController();

  var _passwrodController = TextEditingController();
  @override
  void dispose() {
    _usernameController.dispose();
    _passwrodController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
          key: _formkey,
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              const Text(
                "Login",
                style: TextStyle(fontSize: 40),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    hintText: "Enter UserName",
                    labelText: "Username",
                  ),
                  controller: _usernameController,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value == "")
                      return "Username can't be empty";
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    obscureText: true,
                    controller: _passwrodController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                              width: 2, color: Color.fromARGB(255, 255, 0, 0))),
                      hintText: "Enter Password",
                      labelText: "Password",
                    ),
                    validator: (value) => (value == null || value == "")
                        ? "Please enter your password"
                        : null),
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                child: Text("Login"),
                style: TextButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 255, 255, 255),
                    minimumSize: Size(150, 40)),
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    _formkey.currentState!.save();
                    Navigator.of(context).pushNamed(HomePage.routeName);
                  }
                },
              ),
            ],
          )),
    );
  }
}
