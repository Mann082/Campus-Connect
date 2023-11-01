import 'package:campus_connect/screen/homepage.dart';
import 'package:flutter/material.dart';
import '../widgets/my_button.dart';
import '../widgets/my_text_field.dart';
import '../screen/signup.dart';
import '../providers/auth.dart';
import 'package:provider/provider.dart';
import '../models/http_exception.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool showPass = false;
  bool _obscurePassword = false;
  bool _isloading = false;
  GlobalKey<FormState> _formkey = GlobalKey();
  Map<String, String> _loginData = {};

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
      await Provider.of<Auth>(context, listen: false).signIn(
          _loginData['email'].toString(), _loginData['password'].toString());
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
        title: const Text("LogIn Successful"),
        // content: Text("You can login now"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(HomePage.routeName);
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

  bool checkTheBox = false;
  check() {
    setState(() {
      checkTheBox = !checkTheBox;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
                      const SizedBox(height: 50),
                      Image.asset(
                        "assets/CampusConnectcover.png",
                        color: Color.fromARGB(255, 10, 185, 121),
                        width: MediaQuery.of(context).size.width * 0.7,
                      ),
                      const SizedBox(height: 20),
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
                          controller: _usernameController,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value == null || value == "")
                              return "Username can't be empty";
                          },
                          onSaved: (newValue) {
                            _loginData['email'] = newValue!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: TextFormField(
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            hintText: "Enter Password",
                            labelText: "Password",
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                                icon: _obscurePassword
                                    ? const Icon(
                                        Icons.visibility_outlined,
                                        color: Colors.black,
                                      )
                                    : const Icon(
                                        Icons.visibility_off_outlined,
                                        color: Colors.black,
                                      )),
                          ),
                          controller: _passwrodController,
                          keyboardType: TextInputType.name,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter password.";
                            }
                            //  else if (value !=
                            //     _boxAccounts.get(_controllerUsername.text)) {
                            //   return "Wrong password.";
                            // }

                            return null;
                          },
                          onSaved: (newValue) {
                            _loginData['password'] = newValue!;
                          },
                        ),
                      ),
                      // Padding(
                      //   padding:
                      //       const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      //   child: TextFormField(
                      //     controller: _passwrodController,
                      //     // focusNode: _focusNodePassword,
                      //     // onTapOutside: (_) => _focusNodePassword.unfocus(
                      //     //     disposition: UnfocusDisposition.scope),
                      //     obscureText: _obscurePassword,
                      //     keyboardType: TextInputType.visiblePassword,
                      //     decoration: InputDecoration(
                      //         labelStyle: const TextStyle(color: Colors.white),
                      //         labelText: "Password",
                      //         prefixIcon: const Icon(
                      //           Icons.password_outlined,
                      //           color: Colors.white,
                      //         ),
                      //         suffixIcon: IconButton(
                      //             onPressed: () {
                      //               setState(() {
                      //                 _obscurePassword = !_obscurePassword;
                      //               });
                      //             },
                      //             icon: _obscurePassword
                      //                 ? const Icon(
                      //                     Icons.visibility_outlined,
                      //                     color: Colors.white,
                      //                   )
                      //                 : const Icon(
                      //                     Icons.visibility_off_outlined,
                      //                     color: Colors.white,
                      //                   )),
                      //         border: OutlineInputBorder(
                      //           borderSide: const BorderSide(color: Colors.black),
                      //           borderRadius: BorderRadius.circular(10),
                      //         ),
                      //         enabledBorder: OutlineInputBorder(
                      //           borderSide: const BorderSide(color: Colors.black),
                      //           borderRadius: BorderRadius.circular(10),
                      //         ),
                      //         focusedBorder: OutlineInputBorder(
                      //             borderRadius: BorderRadius.circular(10),
                      //             borderSide: BorderSide(color: Colors.white))),
                      //     validator: (String? value) {
                      //       if (value == null || value.isEmpty) {
                      //         return "Please enter password.";
                      //       }
                      //       //  else if (value !=
                      //       //     _boxAccounts.get(_controllerUsername.text)) {
                      //       //   return "Wrong password.";
                      //       // }

                      //       return null;
                      //     },
                      //   ),
                      // ),
                      const SizedBox(height: 12),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Theme(
                                  data: ThemeData(
                                    unselectedWidgetColor: Colors.grey[500],
                                  ),
                                  child: Checkbox(
                                    checkColor: Colors.white,
                                    value: checkTheBox ? true : false,
                                    onChanged: (value) {
                                      check();
                                    },
                                  ),
                                ),
                                Text(
                                  "Remember me",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                            Text(
                              "Forgot password?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.cyan,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      MyButton(
                          customColor: Color.fromARGB(255, 10, 185, 121),
                          text: "Sign in",
                          onTap: _submit),
                      const SizedBox(height: 20),
                      // Text(
                      //   "Or sign in with",
                      //   style: TextStyle(
                      //     fontSize: 16,
                      //     fontWeight: FontWeight.w500,
                      //     color: Colors.white,
                      //   ),
                      // ),
                      // SizedBox(height: 20),
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
                      //     SizedBox(width: 20),
                      //     Container(
                      //       padding: const EdgeInsets.all(7),
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(10),
                      //         border: Border.all(color: Colors.grey.shade700),
                      //       ),
                      //       child: Image.asset("assets/google.png", width: 50),
                      //     ),
                      //     SizedBox(width: 20),
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
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account ?",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 20),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUp()));
                            },
                            child: Text(
                              "REGISTER",
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
