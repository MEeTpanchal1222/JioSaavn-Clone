import 'package:flutter/material.dart';
import 'package:music_x_audio_player_app_ch6_2/provider/provider.dart';
import 'package:music_x_audio_player_app_ch6_2/screens/home_screen.dart';
import 'package:music_x_audio_player_app_ch6_2/screens/welcome_screen.dart';
import 'package:provider/provider.dart';

import 'modal/song.dart';

Future<void> main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LikedSongsModel()),
        ChangeNotifierProvider(
          create: (context) => IntroProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LikedSongsModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'JioSaavn App',
        home: Provider.of<IntroProvider>(context, listen: true).isClicked
            ? HomeScreen() : WelcomePage(), // Use your main screen here
      ),
    );
  }
}