import 'package:campus_connect/screen/authscreen.dart';
import 'package:campus_connect/screen/homepage.dart';
import 'package:flutter/material.dart';
import '../widgets/my_button.dart';
import '../widgets/my_text_field.dart';
import '../screen/login.dart';
import 'package:provider/provider.dart';
import '../models/http_exception.dart';
import '../providers/auth.dart';

class SignUp extends StatefulWidget {
  static const routeName = '/signup';
  const SignUp({super.key});

  @override
  State<SignUp> createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  bool showPass = false;
  bool _obscurePassword = false;
  bool _isloading = false;
  Map<String, String> _signupData = {};
  GlobalKey<FormState> _formkey = GlobalKey();

  var _usernameController = TextEditingController();

  var _passwrodController = TextEditingController();
  @override
  void dispose() {
    _usernameController.dispose();
    _passwrodController.dispose();
    super.dispose();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Oops!! An Error Occured"),
        content: Text(message),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Okay!"))
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formkey.currentState!.validate()) {
      return;
    }
    _formkey.currentState!.save();
    setState(() {
      _isloading = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false).signup(
          _signupData['email'].toString(), _signupData['password'].toString());
      // Log user in
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains("EMAIL_EXISTS")) {
        errorMessage = "This Email address is already in use";
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = "This is not a valid email";
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = "This Password is too weak";
      } else if (error.toString().contains("EMAIL_NOT_FOUND")) {
        errorMessage = "Couldn't find an user with that email";
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = "The Password you entered is Invalid";
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      var errorMessage = 'Could not authenticate you, please try again later';
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _isloading = false;
    });
    _showSuccessDialog();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("SignUp Successful"),
        content: Text("You can login now"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(authScreen.routeName);
              },
              child: const Text("Okay!"))
        ],
      ),
    );
  }

  showPassword() {
    setState(() {
      showPass = !showPass;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Account"),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: _isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: SafeArea(
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Divider(
                        color: Colors.black,
                        height: 2,
                      ),
                      const SizedBox(height: 60),
                      // const MyTextField(hintText: "Name"),
                      // const SizedBox(height: 12),
                      // const MyTextField(hintText: "Email"),
                      // const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            hintText: "Name",
                            labelText: "Name",
                          ),
                          controller: TextEditingController(),
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value == null || value == "") {
                              return "Username can't be empty";
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            hintText: "Enter Enrollment",
                            labelText: "Enrollment",
                          ),
                          controller: TextEditingController(),
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value == null || value == "") {
                              return "Enrollment can't be empty";
                            } else if (value.length != 12) {
                              return "Enrollment must be of 12 Digits";
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.person),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              hintText: "Enter Email",
                              labelText: "Email",
                            ),
                            controller: TextEditingController(),
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value == null || value == "") {
                                return "Email can't be empty";
                              } else if (!value.contains('@') ||
                                  !value.contains('.')) {
                                return 'Please enter a valid email';
                              }
                            },
                            onSaved: (newValue) {
                              _signupData['email'] = newValue!;
                            }),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: TextFormField(
                          obscureText: true,
                          controller: TextEditingController(),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 255, 0, 0))),
                            hintText: "Enter Password",
                            labelText: "Password",
                          ),
                          validator: (value) => (value == null || value == "")
                              ? "Please enter your password"
                              : null,
                          onSaved: (newValue) {
                            _signupData['password'] = newValue!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: TextFormField(
                            obscureText: false,
                            controller: TextEditingController(),
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      width: 2,
                                      color: Color.fromARGB(255, 255, 0, 0))),
                              hintText: "Confirm Password",
                              labelText: "Confirm Password",
                            ),
                            validator: (value) {
                              if (value == null || value == "")
                                return "Please enter your password";
                              // else if (value !=
                              //   //   _passwrodController.text.toString()) {
                              //   // return "Passwords Does not match";
                              // } else
                              return null;
                            }),
                      ),
                      const SizedBox(height: 30),
                      MyButton(
                          customColor: const Color.fromARGB(255, 10, 185, 121),
                          text: "Sign up",
                          onTap: _submit),
                      const SizedBox(height: 20),
                      // const Text(
                      //   "Or sign up with",
                      //   style: TextStyle(
                      //     fontSize: 16,
                      //     fontWeight: FontWeight.w500,
                      //     color: Colors.white,
                      //   ),
                      // ),
                      // const SizedBox(height: 20),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Container(
                      //       padding: const EdgeInsets.all(7),
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(10),
                      //         border: Border.all(color: Colors.grey.shade700),
                      //       ),
                      //       child: Image.asset("assets/facebook.png", width: 50),
                      //     ),
                      //     const SizedBox(width: 20),
                      //     Container(
                      //       padding: const EdgeInsets.all(7),
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(10),
                      //         border: Border.all(color: Colors.grey.shade700),
                      //       ),
                      //       child: Image.asset("assets/google.png", width: 50),
                      //     ),
                      //     const SizedBox(width: 20),
                      //     Container(
                      //       padding: const EdgeInsets.all(7),
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(10),
                      //         border: Border.all(color: Colors.grey.shade700),
                      //       ),
                      //       child: Icon(
                      //         Icons.apple,
                      //         size: 50,
                      //         color: Colors.white.withOpacity(0.5),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account ?",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 20),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignInPage(),
                                ),
                              );
                            },
                            child: const Text(
                              "LOG IN",
                              style: TextStyle(
                                color: Color.fromARGB(255, 10, 185, 121),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
