import 'package:flutter/material.dart';
import 'package:music_x_audio_player_app_ch6_2/screens/song_player_screen/song_player_screen.dart';
import 'package:provider/provider.dart';
import '../song_player_screen/provider/liked_song_modal.dart';
import '../../uitels/globle_variable.dart';
import '../bottem_navigation_bar_screen/navigation_bar.dart';
import '../home_screen/home_screen.dart';
import '../search_screen/search_screen.dart';
import '../top_artist_screen.dart';

class MyLibrary extends StatefulWidget {
  @override
  _MyLibraryState createState() => _MyLibraryState();
}

class _MyLibraryState extends State<MyLibrary> {
  int _selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
    var likedSongsModel = Provider.of<LikedSongsModel>(context);

    return Scaffold(
      backgroundColor: Color(0xff2a2d36),// Set background color to black
      appBar: AppBar(
        title: Text(
          'My Library',
          style: TextStyle(color: Colors.white), // Set text color to white
        ),
        backgroundColor: Colors.black,
      ),
       body:ListView(
         children: likedSongsModel.likedSongs.map((song) {
           return ListTile(
             title: InkWell(
               onTap: () {
                 Navigator.push(
                   context,
                   MaterialPageRoute(
                     builder: (context) => SongPlayerScreen(
                       songpath: song.path,
                       songName: song.name,
                       imagePath: song.imagePath,
                       isliked: true,
                     ),
                   ),
                 );
               },
               child: Row(
                 children: [
                   Container(
                     height: 80,
                     child: Image.asset('${song.imagePath}', fit: BoxFit.fitHeight),
                   ),
                   SizedBox(width: 20),
                   Text(
                     song.name,
                     style: TextStyle(color: Colors.white, fontSize: 25),
                   ),
                   SizedBox(width: 20),
                   IconButton(
                     onPressed: () {
                       setState(() {
                         likedSongsModel.removeLikedSong(song);
                       });
                     },
                     icon: Icon(Icons.heart_broken_outlined, color: Colors.white),
                   ),
                 ],
               ),
             ),
           );
         }).toList(),
       ),
      bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: _selectedIndex,
          currentIndex: _selectedIndex,
          onItemTapped: (index) {
            setState(() {
              _selectedIndex = index;
            });
            if (_selectedIndex == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            } else if (_selectedIndex == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
            } else if (_selectedIndex == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SongPlayerScreen(
                    songPaths: [recommendedSongs[0].path],
                    songName: recommendedSongs[0].name,
                    imagePath: recommendedSongs[0].imagePath,
                  ),
                ),
              );
            }  else if (_selectedIndex == 4) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen()
                ),
              );
            }
          })
    );
  }
}
