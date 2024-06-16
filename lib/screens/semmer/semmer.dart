import 'package:flutter/material.dart';

import '../home_screen/home_screen.dart';


class semmer extends StatefulWidget {
  const semmer({super.key});

  @override
  State<semmer> createState() => _semmerState();
}

class _semmerState extends State<semmer> {
  void initState() {
    super.initState();
    navigateTohome();
  }
  Future<void> navigateTohome() async {
    // Add a delay before navigating to the login screen
    await Future.delayed(Duration(seconds: 2));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Color(0xff2a2d36),
        body: Center(
          child:
          Image.asset('assets/img.png',height: double.infinity,),

        ),
      );

  }
}
