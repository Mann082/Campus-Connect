import 'package:campus_connect/screen/signup.dart';
import 'package:flutter/material.dart';
import '../widgets/my_button.dart';
import '../screen/login.dart';

class authScreen extends StatefulWidget {
  static const routeName = "/authScreen";
  const authScreen({super.key});

  @override
  State<authScreen> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<authScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 140),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: Image.asset(
                      "assets/CampusConnectcover.png",
                      color: Color.fromARGB(255, 10, 185, 121),
                      width: MediaQuery.of(context).size.width * 0.7,
                    ),
                  ),

                  // sign in button
                  MyButton(
                    customColor: const Color.fromARGB(255, 164, 157, 157)
                        .withOpacity(0.7),
                    text: "Sign in",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignInPage(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  // create an account button
                  MyButton(
                    customColor: Color.fromARGB(255, 10, 185, 121),
                    text: "Create an account",
                    onTap: () {
                      Navigator.of(context).pushNamed(SignUp.routeName);
                    },
                  ),
                ],
              ),

              Spacer(),
              // Footer
              Container(
                margin: EdgeInsets.only(bottom: 40),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Terms of use",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      "Privacy Policy",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
