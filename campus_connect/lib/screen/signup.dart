import 'package:flutter/material.dart';

class signup extends StatefulWidget {
  signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  GlobalKey<FormState> _formkey = GlobalKey();

  var _usernameController = TextEditingController();
  var _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 80,
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
                  keyboardType: TextInputType.name,validator: (value) {
                    if (value == null || value == "")
                      return "Username can't be empty";
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            width: 2,
                            color: const Color.fromARGB(255, 255, 0, 0))),
                    hintText: "Enter Password",
                    labelText: "Password",
                  ),
                  validator:  (value) => (value == null || value == "")
                        ? "Please enter your password"
                        : null),
                ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                child: Text("Sign Up"),
                style: TextButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 255, 255, 255),
                    minimumSize: Size(150, 40)),
                onPressed: () {if (_formkey.currentState!.validate()) {
                    _formkey.currentState!.save();
                  }},
              ),
            ],
          )),
    );
  }
}
