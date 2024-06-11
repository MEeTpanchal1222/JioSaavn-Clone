import 'package:flutter/foundation.dart';
import '../modal/song.dart';

class LikedSongsModel with ChangeNotifier {
  final List<Song> _likedSongs = [];

  List<Song> get likedSongs =>
      _likedSongs.toList(); // Return a copy to prevent modification

  void addLikedSong(Song song) {
    if (!_likedSongs.contains(song)) {
      _likedSongs.add(song);
      notifyListeners();
    }
  }

  void removeLikedSong(Song song) {
    _likedSongs.remove(song);
    notifyListeners();
  }

  bool isLiked(Song song) => _likedSongs.contains(song);
}
