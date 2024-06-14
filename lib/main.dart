import 'package:flutter/material.dart';
import 'package:music_x_audio_player_app_ch6_2/screens/home_screen.dart';
import 'package:music_x_audio_player_app_ch6_2/screens/welcome_screen.dart';
import 'package:provider/provider.dart';

import 'modal/song.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // runApp(
  //   ChangeNotifierProvider(
  //     create: (context) => LikedSongsModel(),
  //     child: MyApp(),
  //   ),
  // );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LikedSongsModel()),
        // Add other providers if needed
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
        home: WelcomePage(), // Use your main screen here
      ),
    );
  }
}