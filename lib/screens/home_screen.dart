import 'package:flutter/material.dart';

// import 'package:firebase_auth/firebase_auth.dart';
import '../uitels/globle_variable.dart';
import 'email_auth/login_screen.dart';
import 'library_screen/library_screen.dart';
import 'navigation_bar.dart';
import 'search_screen.dart';
import 'song_player_screen.dart';
import 'top_artist_screen.dart';

class Song {
  final String name;
  final String path;
  final String imagePath;

  Song({
    required this.name,
    required this.path,
    required this.imagePath,
  });
}

List<Song> recommendedSongs = [
  Song(
      name: 'Alone',
      path: 'assets/songs/song1.mp3',
      imagePath: 'assets/song1.png'),
  Song(
      name: 'Kesariya',
      path: 'assets/songs/song2.mp3',
      imagePath: 'assets/song2.png'),
  Song(
      name: 'We own it',
      path: 'assets/songs/song3.mp3',
      imagePath: 'assets/song3.png'),
];

// Add this function outside the HomeScreen class
Future<List<String>> fetchTopSongsForArtist(String artistName) async {
  // Simulate fetching data, replace this with actual data fetching logic
  await Future.delayed(Duration(seconds: 2)); // Simulating a delay
  // Hardcoded top songs for each artist
  Map<String, List<String>> artistTopSongs = {
    'Travis Scott': ['song1.mp3', 'song2.mp3', 'song3.mp3'],
    'Sonu Nigam': ['song4.mp3', 'song5.mp3', 'song6.mp3'],
    'Drake': ['song7.mp3', 'song8.mp3', 'song9.mp3'],
    // Add more artists and their top songs as needed
  };

  return artistTopSongs[artistName] ?? [];
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void logout() async {
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  Widget _buildSuggestedItem(BuildContext context, Song song) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SongPlayerScreen(
              songPaths: [song.path],
              songName: song.name,
              imagePath: song.imagePath,
            ),
          ),
        );
      },
      child: Container(
        width: 120,
        margin: EdgeInsets.only(right: 5),
        child: Column(
          children: [
            Image.asset(
              song.imagePath,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 5),
            Text(
              song.name,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageRow(List<Song> songs) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: songs.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () async {
              print('Tapped on ${songs[index].name}');

              // Fetch the top songs for the selected artist
              List<String> topSongs =
                  await fetchTopSongsForArtist(songs[index].name);
              print('Top songs for ${songs[index].name}: $topSongs');

              // Navigate to TopArtistSongsScreen with the fetched top songs
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TopArtistSongsScreen(
                    artistName: songs[index].name,
                    topSongs: topSongs,
                  ),
                ),
              );
            },
            child: _buildSuggestedItem(context, songs[index]),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Song> topArtists = [
      Song(
          name: 'Travis Scott',
          path: 'assets/songs/eminem.mp3',
          imagePath: 'assets/travis.png'),
      Song(
          name: 'Sonu Nigam',
          path: 'assets/songs/arjit.mp3',
          imagePath: 'assets/sonu.png'),
      Song(
          name: 'Drake',
          path: 'assets/songs/selena.mp3',
          imagePath: 'assets/drake.png'),
    ];

    List<Song> newReleases = [
      Song(
          name: 'Phle bhi main',
          path: 'assets/songs/new1.mp3',
          imagePath: 'assets/phlebhimain.png'),
      Song(
          name: 'Satranga',
          path: 'assets/songs/new2.mp3',
          imagePath: 'assets/satranga.png'),
      Song(
          name: 'Duniya jala denge',
          path: 'assets/songs/new3.mp3',
          imagePath: 'assets/sariduniya.png'),
    ];

    List<Song> jioSaavnPicks = [
      Song(
          name: 'Challeya',
          path: 'assets/songs/pick1.mp3',
          imagePath: 'assets/challeya.png'),
      Song(
          name: 'Zinda Banda',
          path: 'assets/songs/pick2.mp3',
          imagePath: 'assets/zindabanda.png'),
      Song(
          name: 'Jawan Title Track',
          path: 'assets/songs/pick3.mp3',
          imagePath: 'assets/jawan.png'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 80,
          child: Image.asset('assets/JioSaavn Logo White Transparent.png',fit: BoxFit.fitWidth,),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff2a2d36),
        actions: [
          IconButton(
            onPressed: () {
              logout();
            },
            icon: Icon(Icons.exit_to_app,color: Colors.white,),
          ),
        ],
      ),
      backgroundColor: Color(0xff2a2d36),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Music',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(height: 20),
              Text(
                'Recommended Songs for you:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              SizedBox(height: 25),
              _buildImageRow(recommendedSongs),
              SizedBox(height: 20),
              Text(
                'Top artists for you:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              SizedBox(height: 25),
              _buildImageRow(topArtists),
              SizedBox(height: 20),
              Text(
                'New Releases:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              SizedBox(height: 25),
              _buildImageRow(newReleases),
              SizedBox(height: 20),
              Text(
                'Jio Saavn picks:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              SizedBox(height: 25),
              _buildImageRow(jioSaavnPicks),
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
            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
            } else if (index == 2) {
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
            } else if (index == 3) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyLibrary()),
              );
            } else if (index == 4) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TopArtistSongsScreen(
                    artistName: topArtists[0].name,
                    topSongs: musicList,
                  ),
                ),
              );
            }
          }),
    );
  }
}
