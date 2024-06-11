import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:music_x_audio_player_app_ch6_2/screens/email_auth/signup_screen.dart';

import '../phone_auth/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String errorMessage = ''; // Added to manage error message

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email == "" || password == "") {
      setState(() {
        errorMessage = "Please enter all the required details!";
      });
    } else {
      // try {
      //   UserCredential userCredential = await FirebaseAuth.instance
      //       .signInWithEmailAndPassword(email: email, password: password);
      //   if (userCredential.user != null) {
           Navigator.popUntil(context, (route) => route.isFirst);
           Navigator.pushReplacement(
            context,
             CupertinoPageRoute(
               builder: (context) => HomeScreen(),
             ),
          );
      //   }
      // } on FirebaseAuthException catch (ex) {
      //   log(ex.code.toString());
      //   setState(() {
      //     errorMessage = "Incorrect email or password.";
      //   });
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/jiosaavn_name.png',
                      height: 150,
                      width: 200,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Login and enjoy more than 80 million songs',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Color.fromARGB(198, 202, 189, 189),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      controller: emailController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Email",
                        labelStyle: TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      controller: passwordController,
                      style: TextStyle(color: Colors.white),
                      obscureText: true, // Hide the password while typing
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Password",
                        labelStyle: TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 35),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 117, 255, 220),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            errorMessage =
                            ''; // Clear error message on button press
                          });
                          login();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Or',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    CupertinoButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => SignUpScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Create an Account",
                        style: TextStyle(
                            color: const Color.fromRGBO(
                                0, 250, 240, 1)), // Set the text color
                      ),
                    ),
                    SizedBox(height: 15),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  errorMessage,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
                // Display error message
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'By continuing, you agree to our terms and privacy policy',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
