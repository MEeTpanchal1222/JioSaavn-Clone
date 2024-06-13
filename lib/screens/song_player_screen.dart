import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart' as just_audio;
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class LikedSongsModel with ChangeNotifier {
  List<Song> _likedSongs = [];

  List<Song> get likedSongs => _likedSongs;

  void addLikedSong(Song song) {
    _likedSongs.add(song);
    notifyListeners();
  }
}

class SongPlayerScreen extends StatefulWidget {
  final List<String> songPaths;
  final String songName;
  final String imagePath;

  SongPlayerScreen({
    required this.songPaths,
    required this.songName,
    required this.imagePath,
  });

  @override
  _SongPlayerScreenState createState() => _SongPlayerScreenState();
}

class _SongPlayerScreenState extends State<SongPlayerScreen> {
  late just_audio.AudioPlayer _audioPlayer;
  bool isPlaying = true;
  int currentIndex = 0;
  bool liked = false;
  Duration _duration = const Duration();
  Duration _position = const Duration();

  @override
  void initState() {
    super.initState();

    _audioPlayer = just_audio.AudioPlayer();

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
    await _audioPlayer.setAsset(widget.songPaths[currentIndex]);
  }

  void _likeSong(BuildContext context) {
    var likedSongsModel = Provider.of<LikedSongsModel>(context, listen: false);

    Song likedSong = Song(
      id: Uuid().v4(),
      name: widget.songName,
      path: widget.songPaths[currentIndex],
      imagePath: widget.imagePath,
    );

    if (liked) {
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
      appBar: AppBar(
        title: Text('Now Playing'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              widget.imagePath,
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              widget.songName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text(_position.toStringAsFixed(2).padLeft(5, '0')),
                 Text(_position.toString().split(".")[0]),
                Expanded(
                  child: Slider(
                    activeColor: Colors.black,
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
                Text(_duration.toString().split(".")[0])
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.skip_previous),
                  onPressed: _skipToPrevious,
                ),
                IconButton(
                  icon: isPlaying ? Icon(Icons.pause) : Icon(Icons.play_arrow),
                  onPressed: () {
                    if (isPlaying) {
                      _audioPlayer.pause();
                    } else {
                      _audioPlayer.play();
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.skip_next),
                  onPressed: _skipToNext,
                ),
                IconButton(
                  icon: Icon(liked ? Icons.favorite : Icons.favorite_border),
                  onPressed: () {
                    addLikedSong()
                    _likeSong(context);
                  },
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
      currentIndex--;
      _audioPlayer.seek(Duration.zero, index: currentIndex);
    }
  }

  void _skipToNext() {
    if (currentIndex < widget.songPaths.length - 1) {
      currentIndex++;
      _audioPlayer.seek(Duration.zero, index: currentIndex);
    }
  }
}

class Song {
  final String id;
  final String name;
  final String path;
  final String imagePath;

  Song({
    required this.id,
    required this.name,
    required this.path,
    required this.imagePath,
  });
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String img_cover_url =
      "https://i.pinimg.com/736x/a7/a9/cb/a7a9cbcefc58f5b677d8c480cf4ddc5d.jpg";

  bool isPlaying = false;
  double value = 0;
  final player = AudioPlayer();
  Duration? duration;

  void initPlayer() async {
    await player.setSource(AssetSource("music.mp3"));
    duration = await player.getDuration();
  }

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            constraints: BoxConstraints.expand(),
            height: 300.0,
            width: 300.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/cover.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
              child: Container(
                color: Colors.black.withOpacity(0.6),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Image.asset(
                  "assets/cover.jpg",
                  width: 250.0,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Summer",
                style: TextStyle(
                    color: Colors.white, fontSize: 36, letterSpacing: 6),
              ),
              SizedBox(
                height: 50.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${(value / 60).floor()}: ${(value % 60).floor()}",
                    style: TextStyle(color: Colors.white),
                  ),
                  Container(
                    width: 260.0,
                    child: Slider.adaptive(
                      onChangeEnd: (new_value) async {
                        setState(() {
                          value = new_value;
                          print(new_value);
                        });
                        await player.seek(Duration(seconds: new_value.toInt()));
                      },
                      min: 0.0,
                      value: value,
                      max: 214.0,
                      onChanged: (new_value) {
                        setState(() {
                          value = new_value;
                        });
                      },
                      activeColor: Colors.white,
                    ),
                  ),
                  if (duration != null)
                    Text(
                      "${duration!.inMinutes} : ${duration!.inSeconds % 60}",
                      style: TextStyle(color: Colors.white),
                    ),
                ],
              ),
              SizedBox(
                height: 60.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60.0),
                      color: Colors.black87,
                      border: Border.all(color: Colors.white38),
                    ),
                    width: 50.0,
                    height: 50.0,
                    child: InkWell(
                      onTapDown: (details) {
                        player.setPlaybackRate(0.5);
                      },
                      onTapUp: (details) {
                        player.setPlaybackRate(1);
                      },
                      child: Center(
                        child: Icon(
                          Icons.fast_rewind_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60.0),
                      color: Colors.black87,
                      border: Border.all(color: Colors.pink),
                    ),
                    width: 60.0,
                    height: 60.0,
                    child: InkWell(
                      onTap: () async {
                        await player.resume();
                        player.onPositionChanged.listen(
                              (Duration d) {
                            setState(() {
                              value = d.inSeconds.toDouble();
                              print(value);
                            });
                          },
                        );
                        print(duration);
                      },
                      child: Center(
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60.0),
                      color: Colors.black87,
                      border: Border.all(color: Colors.white38),
                    ),
                    width: 50.0,
                    height: 50.0,
                    child: InkWell(
                      onTapDown: (details) {
                        player.setPlaybackRate(2);
                      },
                      onTapUp: (details) {
                        player.setPlaybackRate(1);
                      },
                      child: Center(
                        child: Icon(
                          Icons.fast_forward_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}