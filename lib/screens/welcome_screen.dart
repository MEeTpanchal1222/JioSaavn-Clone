import 'dart:async';
import 'package:flutter/material.dart';
import 'package:music_x_audio_player_app_ch6_2/screens/home_screen.dart';

import '../uitels/globle_variable.dart';
import 'email_auth/login_screen.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    navigateToLogin();
  }

  Future<void> navigateToLogin() async {
    // Add a delay before navigating to the login screen
    await Future.delayed(Duration(seconds: 3));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
      nullallways != null ?
      HomeScreen()
          : Scaffold(
        backgroundColor: Color(0xff2a2d36),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              Image.asset('assets/jio_saavn_black_logo.png'),
            ],
          ),
        ),
      ),
    );
  }

}
