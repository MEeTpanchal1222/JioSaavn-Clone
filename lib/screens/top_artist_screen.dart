import 'package:flutter/material.dart';
import 'package:music_x_audio_player_app_ch6_2/screens/song_player_screen.dart';

// Define a static map of artists to their top songs
Map<String, List<String>> artistTopSongs = {
  'Travis Scott': ['song1.mp3', 'song2.mp3', 'song3.mp3'],
  'Sonu Nigam': ['song4.mp3', 'song5.mp3', 'song6.mp3'],
  'Drake': ['song7.mp3', 'song8.mp3', 'song9.mp3'],
  // Add more artists and their top songs as needed
};

class TopArtistSongsScreen extends StatelessWidget {
  final String artistName;
  final List<String> topSongs;

  TopArtistSongsScreen({
    required this.artistName,
    required this.topSongs,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(artistName,style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
      ),
      backgroundColor:Color(0xff2a2d36),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Top Songs form $artistName:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            _buildTopSongsList(context), // Pass context here
          ],
        ),
      ),
    );
  }

  Widget _buildTopSongsList(BuildContext context) {
    return ListView.builder(
      itemCount: topSongs.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(topSongs[index]),
          onTap: () {
            // Navigate to SongPlayerScreen with the selected song
            navigateToSongPlayer(context, topSongs[index]);
          },
        );
      },
    );
  }
  void navigateToSongPlayer(BuildContext context, String songTitle) {
    // Get the song paths for the selected artist
    List<String> artistSongs = artistTopSongs[artistName] ?? [];

    print('Artist Songs: $artistSongs');


    List<String> songPaths = artistSongs
        .map((song) => 'assets/songs/$song')
        .toList();

    print('Song Paths: $songPaths');

    // Navigate to SongPlayerScreen with the required parameters
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SongPlayerScreen(
          songPaths: songPaths,
          songName: songTitle,
          // Replace with the actual image path
          imagePath: 'assets/arjit.png',
        ),
      ),
    );
  }

}
