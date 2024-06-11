import 'package:flutter/material.dart';

class LikedSongsModel with ChangeNotifier {
  List<Song> _likedSongs = [];

  List<Song> get likedSongs => _likedSongs;

  void toggleLikedSong(Song song) {
    if (_likedSongs.contains(song)) {
      _likedSongs.remove(song);
    } else {
      _likedSongs.add(song);
    }
    notifyListeners();
  }
}

class Song {
  final String name;
  final String path;
  final String imagePath;

  Song({
    required this.name,
    required this.path,
    required this.imagePath, required String id,
  });

}

