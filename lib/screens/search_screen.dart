import 'package:flutter/material.dart';
import 'package:music_x_audio_player_app_ch6_2/screens/home_screen.dart';
import 'library_screen/library_screen.dart';
import 'navigation_bar.dart';
import 'song_player_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int _selectedIndex = 1; // Set the default index to Search

  // Map of song titles to image paths
  Map<String, String> songImagesMap = {
    'Phle bhi main': 'assets/phlebhimain.png',
    'Satranga': 'assets/satranga.png',
    'Duniya Jala Denge': 'assets/sariduniya.png',
    'Alone': 'assets/song1.png',
    'Kesariya': 'assets/song2.png',
    'We Own it': 'assets/song3.png',
    'Challeya': 'assets/challeya.png',
    'Zinda Banda': 'assets/zindabanda.png',
    'Jawan Title Track': 'assets/jawan.png',
    'Tu Maro Daryo' :'assets/tu maro.jpg',
    'AGAR TUM SAATH':'assets/agar.jpg',
    'Nanpan No Nedlo' : 'assets/nanpan.jpg',
    'Khoya Hain' : 'assets/khoya.jpg',
    'Papa Meri Jan' : 'assets/papa.jpg',
    'Chandaliyo Ugyo Re' : 'assets/chandaliyo.jpg',
    'shiddat' : 'assets/shiddat.jpg',
    'Tum Se' :  'assets/tumse.jpg',
    'Phir Bhi Aas Lagi Hai Dil Mein' : 'assets/phirbhi.jpg',
    'O Maahi' : 'assets/omaahi.jpg',
    'Apna Bana Le' : 'assets/apna.jpg',
    'Tu Hai kaya mere liye ' :  'assets/mere.jpg',
    'Dil Meri Na sune' :'assets/dil.jpg',
    'Tainu Khabar Nahi' : 'assets/tainu.jpg',
    'Humsafar ':  'assets/hamdafar.jpg',
    'Thara Paisa Thari' : 'assets/thara.jpg',
    'Tum jo Aaye Zindagi' : 'assets/tum.jpg',
    'Hum Nahi Sudhrenge ' : 'assets/hum.jpg',


  };

  Map<String, String> songPathsMap = {
    'Phle bhi main': 'assets/songs/new1.mp3',
    'Satranga': 'assets/songs/new2.mp3',
    'Duniya Jala Denge': 'assets/songs/new3.mp3',
    'Alone': 'assets/songs/song1.mp3',
    'Kesariya': 'assets/songs/song2.mp3',
    'We Own it': 'assets/songs/song3.mp3',
    'Challeya': 'assets/songs/pick1.mp3',
    'Zinda Banda': 'assets/songs/pick2.mp3',
    'Jawan Title Track': 'assets/songs/pick3.mp3',


    'Tu Maro Daryo' : "assets/songs/Tu Maaro Dariyo.mp3",
    'AGAR TUM SAATH':"assets/songs/tum saath.mp3",
    'Nanpan No Nedlo' :  "assets/songs/nanpan.mp3",
    'Khoya Hain' : "assets/songs/khoya.mp3",
    'Papa Meri Jan' :  "assets/songs/papa.mp3",
    'Chandaliyo Ugyo Re' : "assets/songs/Chandaliyo.mp3",
    'shiddat' : "assets/songs/shiddat.mp3",
    'Tum Se' :  'assets/songs/tumse.jpg',
    'Phir Bhi Aas Lagi Hai Dil Mein' : 'assets/songs/phirbhi.jpg',
    'O Maahi' : 'assets/songs/omaahi.jpg',
    'Apna Bana Le' : 'assets/songs/apna.jpg',
    'Tu Hai kaya mere liye ' :  'assets/songs/mere.jpg',
    'Dil Meri Na sune' :"assets/songs/dil.mp3",
    'Tainu Khabar Nahi' :  "assets/songs/tainu.mp3",
    'Humsafar ':  "assets/songs/Humsafar.mp3",
    'Thara Paisa Thari' : "assets/songs/Thara.mp3",
    'Tum jo Aaye Zindagi' :  "assets/songs/Tum.mp3",
    'Hum Nahi Sudhrenge ' : "assets/songs/hum.mp3",

  };

  List<String> allSongTitles = [
    'Phle bhi main',
    'Satranga',
    'Duniya Jala Denge',
    'Alone',
    'We Own it',
    'Kesariya',
    'Jawan Title Track',
    'Zinda Banda',
    'Challeya',
    'Tu Maro Daryo',
    'AGAR TUM SAATH',
    'Nanpan No Nedlo',
    'Khoya Hain',
    'Papa Meri Jan',
    'Chandaliyo Ugyo Re',
    'shiddat',
    'Tum Se',
    'Phir Bhi Aas Lagi Hai Dil Mein',
    'O Maahi',
    'Apna Bana Le',
    'Tu Hai kaya mere liye ',
    'Dil Meri Na sune',
    'Tainu Khabar Nahi',
    'Humsafar ',
    'Thara Paisa Thari',
    'Tum jo Aaye Zindagi',
    'Hum Nahi Sudhrenge ',

  ]; // Add all your song titles

  List<String> displayedSongs = []; // Songs to be displayed based on the search

  @override
  void initState() {
    displayedSongs = allSongTitles;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set background color here

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Add your search bar here
              _buildSearchBar(),

              // Add the top trending songs title
              Text(
                'What\'s Trending this week:',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),

              // Display the songs based on the search
              _buildSongList(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedIndex = index;
          });
          if (_selectedIndex == 0) {
            // Navigate to HomeScreen when the Home tab is tapped
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          } else if (_selectedIndex == 2) {
            // Navigate to MyLibrary when the Library tab is tapped
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyLibrary()),
            );
          }
        },
        currentIndex: _selectedIndex,
      ),
    );
  }

  Color _getColor(int index) {
    return _selectedIndex == index
        ? Colors.white
        : const Color.fromARGB(255, 128, 128, 128);
  }

  Widget _buildSearchBar() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Music',
          hintStyle: TextStyle(color: Colors.grey),
          suffixIcon: Icon(Icons.search, color: Colors.white),
          border: InputBorder.none,
        ),
        onChanged: (value) {
          // Update the displayed songs based on the search
          setState(() {
            displayedSongs = allSongTitles
                .where((song) =>
                song.toLowerCase().contains(value.toLowerCase()))
                .toList();
          });
        },
      ),
    );
  }

  Widget _buildSongList() {
    // Check if the search bar is empty, and only show the trending text if it is
    if (displayedSongs.isEmpty) {
      return Center(
        child: Text(
          'No matching songs found.',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      );
    }

    // Take only the top 3 songs from the displayed songs
    List<String> top3Songs = displayedSongs.take(3).toList();

    return Column(
      children: top3Songs.map((songTitle) {
        return _buildSuggestedItem(songTitle);
      }).toList(),
    );
  }

  Widget _buildSuggestedItem(String songTitle) {
    return GestureDetector(
      onTap: () {
        // Provide necessary parameters to SongPlayerScreen
        navigateToSongPlayer(songTitle);
      },
      child: Column(
        children: [
          Image.asset(
            // Get the image path based on the song title
            songImagesMap[songTitle] ?? 'assets/default_image.png',
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 5),
          Text(
            songTitle,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  void navigateToSongPlayer(String songTitle) {
    // Perform any logic to get the song path based on the title
    String songPath = getSongPath(songTitle);

    // Navigate to SongPlayerScreen with the required parameters
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SongPlayerScreen(
          songPaths: [
            songPath
          ], // Pass the song path or paths based on your logic
          songName: songTitle,
          // Use the same logic to get the image path
          imagePath: songImagesMap[songTitle] ?? 'assets/default_image.png',
        ),
      ),
    );
  }

  String getSongPath(String songTitle) {
    // Replace this logic with your actual logic to get the song path based on the title
    // Assuming you have a dynamic list of songs
    Map<String, String> songPathsMap = {
      'Phle bhi main': 'assets/songs/new1.mp3',
      'Satranga': 'assets/songs/new2.mp3',
      'Duniya Jala Denge': 'assets/songs/new3.mp3',
      'Alone': 'assets/songs/song1.mp3',
      'Kesariya': 'assets/songs/song2.mp3',
      'We Own it': 'assets/songs/song3.mp3',
      'Challeya': 'assets/songs/pick1.mp3',
      'Zinda Banda': 'assets/songs/pick2.mp3',
      'Jawan Title Track': 'assets/songs/pick3.mp3',
      // Add more entries as needed
    };
    return songPathsMap[songTitle] ?? '';
  }
}
