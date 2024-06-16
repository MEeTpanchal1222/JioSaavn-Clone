import 'dart:ffi';
import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart' as just_audio;
import 'package:music_x_audio_player_app_ch6_2/modal/song.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'provider/liked_song_modal.dart';




class SongPlayerScreen extends StatefulWidget {
  final List<String> ?songPaths;
  final List<String> ?songNames;
  final List<String> ?imagePaths;
  final String? songName;
  final String? imagePath;
  final String? songpath;
  final bool? isliked;

  SongPlayerScreen({
    this.imagePaths,
    this.songNames,
    this.isliked,
    this.songpath,
    this.songPaths,
     this.songName,
     this.imagePath,
  });


  @override
  _SongPlayerScreenState createState() => _SongPlayerScreenState();
}

class _SongPlayerScreenState extends State<SongPlayerScreen> {
  late just_audio.AudioPlayer _audioPlayer;
  bool isPlaying = false;
  int currentIndex = 0;
  bool liked = false;

  Duration _duration = const Duration();
  Duration _position = const Duration();

  @override
  void initState() {
    super.initState();

    _audioPlayer = just_audio.AudioPlayer();
    (widget.isliked != null)?this.liked =widget.isliked!:this.liked =false;

    _audioPlayer.playerStateStream.listen((playerState) {
      setState(() {
        isPlaying = playerState.playing;
      });
    });

    _audioPlayer.durationStream.listen((d) {
      setState(() {
        _duration = d!;
      });
    });

    _audioPlayer.positionStream.listen((p) {
      setState(() {
        _position = p;
      });
    });

    initPlayer();
  }

  void initPlayer() async {
    await _audioPlayer.setAsset((widget.songPaths != null)? widget.songPaths![currentIndex]:widget.songpath!,);
  }

  void _likeSong(BuildContext context) {
    var likedSongsModel = Provider.of<LikedSongsModel>(context, listen: false);


    Song likedSong = Song(
      id: Uuid().v4(),
      name:  (widget.songNames == null)?widget.songName!:widget.songNames![currentIndex],
      path:(widget.songPaths != null)? widget.songPaths![currentIndex]:widget.imagePath!,
      imagePath: (widget.imagePaths != null)?widget.imagePaths![currentIndex]:widget.imagePath!,
    );

    if ( liked) {
      likedSongsModel.likedSongs.remove(likedSong);
      setState(() {
        liked = false;
      });
      _showSnackBar(context, 'Song removed from Liked Songs');
    } else {
      likedSongsModel.addLikedSong(likedSong);
      setState(() {
        liked = true;
      });
      _showSnackBar(context, 'Song added to Liked Songs');
    }
  }


  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(

        backgroundColor: Colors.black38,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
            child: Icon(Icons.close,color: Colors.white,)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  (widget.imagePaths == null)?widget.imagePath!:widget.imagePaths![currentIndex],
                  height: 350,
                  width: 350,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              (widget.songNames == null)?widget.songName!:widget.songNames![currentIndex],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white),
            ),
            SizedBox(height: 90),
            Padding(
              padding: const EdgeInsets.fromLTRB(35, 80, 35, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Text(_position.toString().split('.')[0],style: TextStyle(color: Colors.white),),
                  Expanded(
                    child: Slider(
                      activeColor: Color(0xff1ecdb0),
                      min: const Duration(microseconds: 0).inSeconds.toDouble(),
                      value: _position.inSeconds.toDouble(),
                      max: _duration.inSeconds.toDouble(),
                      onChanged: (value) {
                        setState(() {
                          changeToSeconds(value.toInt());
                          value = value;
                        });
                      },
                    ),
                  ),
                  Text(_duration.toString().split(".")[0],style: TextStyle(color: Colors.white),)
                ],
              ),
            ),
            Row(
              children: [
                SizedBox(width: 30,),
                IconButton(
                  icon: Icon(liked ? Icons.favorite : Icons.favorite_border, color: Colors.red,),
                  onPressed: () {
                    _likeSong(context);

                  },
                ),
                SizedBox(width: 50,),
                IconButton(
                  icon: Icon(Icons.skip_previous,color: Colors.white,size: 45,),
                  onPressed: _skipToPrevious,
                ),
                IconButton(
                  icon: isPlaying ? Icon(Icons.pause,color: Colors.white,size: 50,) : Icon(Icons.play_arrow,color: Colors.white,size: 50,),
                  onPressed: () {
                    if (isPlaying) {
                      _audioPlayer.pause();
                    } else {
                      _audioPlayer.play();
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.skip_next,color: Colors.white,size: 45,),
                  onPressed: _skipToNext

                ),

              ],
            ),
          ],
        ),
      ),
    );
  }

  void changeToSeconds(int seconds) {
    Duration duration = Duration(seconds: seconds);
    _audioPlayer.seek(duration);
  }

  void _skipToPrevious() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
      _audioPlayer.seek(Duration.zero, index: currentIndex);
      initPlayer();
    }
  }

  void _skipToNext() {
    if (currentIndex < widget.songPaths!.length - 1) {
      setState(() {
        currentIndex++;
      });
      _audioPlayer.seek(Duration.zero, index: currentIndex);
      initPlayer();
    }
  }
}

