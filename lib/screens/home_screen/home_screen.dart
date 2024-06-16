import 'package:flutter/material.dart';

import '../../uitels/globle_variable.dart';
import '../bottem_navigation_bar_screen/navigation_bar.dart';
import '../email_auth/login_screen.dart';
import '../library_screen/library_screen.dart';
import '../search_screen/search_screen.dart';
import '../song_player_screen/song_player_screen.dart';
import '../top_artist_screen.dart';

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
      name: 'StarBoy',
      path: 'assets/songs/Starboy(PagalWorld).mp3',
      imagePath: 'assets/song5.png'),
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

  Map<String, List<String>> artistTopSongs = {
    'Travis Scott': ['song1.mp3', 'song2.mp3', 'song3.mp3'],
    'Sonu Nigam': ['assets/songs/shiddat.mp3', 'assets/songs/pehle.mp3', 'assets/songs/papa.mp3'],
    'Drake': ['song7.mp3', 'song8.mp3', 'song9.mp3'],
    // Add more artists and their top songs as needed
  };

  return artistTopSongs[artistName] ?? [];
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
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


              List<String> topSongs =
                  await fetchTopSongsForArtist(songs[index].name);
              print('Top songs for ${songs[index].name}: $topSongs');


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
  Widget buildimageonly(List songs){
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: songs.length,
        itemBuilder: (BuildContext context, int index) {
          return   Container(
            width: 120,
            margin: EdgeInsets.only(right: 5),
            child: Column(
              children: [
                Image.asset(
                  songs[index]['imagePath'],
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 5),
                Text(
                  songs[index]['name'],
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
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

    List<Song> modename =[
      Song(
          name: "Romantic duets",
          path: 'assets/songs/apna.mp3',
          imagePath: 'assets/list_image_that_not_for_onlyshow/img.png'),
      Song(
          name:  "Ghazalon ki mehfil",
          path: 'assets/songs/Humsafar.mp3',
          imagePath: 'assets/list_image_that_not_for_onlyshow/img_1.png'),
      Song(
          name: "desi Hip Hop",
          path: 'assets/songs/Humsafar.mp3',
          imagePath: 'assets/list_image_that_not_for_onlyshow/img_2.png'),
      Song(
          name: "Bollywood decade 2010s",
          path: 'assets/songs/pick3.mp3',
          imagePath: 'assets/list_image_that_not_for_onlyshow/img_3.png'),
      Song(
          name: "Desh prem",
          path: 'assets/songs/arjit.mp3',
          imagePath: 'assets/list_image_that_not_for_onlyshow/img_4.png'),
      Song(
          name: "Unplugged Hits",
          path: 'assets/songs/dil.mp3',
          imagePath: 'assets/list_image_that_not_for_onlyshow/img_5.png'),
      Song(
          name: "Pyaar Ke Saathi",
          path: 'assets/songs/apna.mp3',
          imagePath: 'assets/list_image_that_not_for_onlyshow/img_6.png'),
      Song(
          name: "Sirf love",
          path: 'assets/songs/omaahi.mp3',
          imagePath: 'assets/list_image_that_not_for_onlyshow/img_7.png'),

    ];
    List posteronly =[
      {
        "imagePath" :"assets/list_image_that_not_for_onlyshow/topcharts/img.png",
        "name":"Trading today",
      },
      {
        "imagePath":"assets/list_image_that_not_for_onlyshow/topcharts/img_1.png",
        "name":"Romantic Top 40",
      },
      {
        "imagePath":"assets/list_image_that_not_for_onlyshow/topcharts/img_2.png",
        "name":"Hindi 2000s",
      },
      {
        "imagePath":"assets/list_image_that_not_for_onlyshow/topcharts/img_3.png",
        "name":"Hindi 1990s",
      },
      {
        "imagePath":"assets/list_image_that_not_for_onlyshow/topcharts/img_4.png",
        "name":"Hindi 1980s",
      },
      {
        "imagePath":"assets/list_image_that_not_for_onlyshow/topcharts/img_5.png",
        "name":"Hindi 1970s",
      },
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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              'Music',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                            Container(
                              height: 3,
                              width: 70,
                              color: Color(0xff4db6ac),
                            )
                          ],
                        ),
                        SizedBox(width: 20,),
                        Text(
                          'Podcasts',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffbdbec9),
                          ),
                        ),
                        SizedBox(width: 20,),
                        Text(
                          'JioTunes',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffbdbec9),
                          ),
                        ),
                        SizedBox(width: 80,),
                        IconButton(onPressed:() {

                        }, icon: Icon(Icons.settings_outlined,color: Colors.white,size: 28,))
                      ],
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
              SizedBox(height: 20),
              Text(
                'Pick Your Mode :',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              SizedBox(height: 25),
              _buildImageRow(modename),
              SizedBox(height: 20),
              SizedBox(height: 20),
              Text(
                'Top Charts :',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              SizedBox(height: 25),
              buildimageonly(posteronly),
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
      bottomNavigationBar: bottem_navigation(context, topArtists),
    );
  }
  CustomBottomNavigationBar bottem_navigation(BuildContext context, List<Song> topArtists) {
    return CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        currentIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedIndex = index;
          });
          if (_selectedIndex == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchScreen()),
            );
          } else if (_selectedIndex == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SongPlayerScreen(
                  imagePaths: songimage,
                  songNames: Songsname,
                  songPaths: musicList,
                ),
              ),
            );
          } else if (_selectedIndex == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyLibrary()),
            );
          } else if (_selectedIndex == 4) {
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
        });

  }
}
