import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../modal/song.dart';
import '../navigation_bar.dart';
import '../search_screen.dart';

class MyLibrary extends StatefulWidget {
  @override
  _MyLibraryState createState() => _MyLibraryState();
}

class _MyLibraryState extends State<MyLibrary> {
  int _currentIndex = 2; // Default index for My Library tab

  @override
  Widget build(BuildContext context) {
    var likedSongsModel = Provider.of<LikedSongsModel>(context);

    return Scaffold(
      backgroundColor: Colors.black, // Set background color to black
      appBar: AppBar(
        title: Text(
          'My Library',
          style: TextStyle(color: Colors.white), // Set text color to white
        ),
        backgroundColor: Colors.black, // Set app bar background color to black
      ),
      body: ListView.builder(
        itemCount: likedSongsModel.likedSongs.length,
        itemBuilder: (context, index) {
          var song = likedSongsModel.likedSongs[index];
          return ListTile(
            title: Text(
              song.name,
              style: TextStyle(color: Colors.white), // Set text color to white
            ),
            // You can add more details like artist, album, etc. here
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _currentIndex,
        onItemTapped: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (_currentIndex == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchScreen()),
            );
          } else if (_currentIndex == 2) {
            // Do nothing, already on My Library screen
          }
        },
        currentIndex: _currentIndex,
      ),
    );
  }
}
