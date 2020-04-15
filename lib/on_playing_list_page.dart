import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer/OnPlayingListTile.dart';
import 'neumorphic_circle.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class OnPlayingListPage extends StatefulWidget {
  OnPlayingListPage({Key key}) : super(key: key);

  @override
  _OnPlayingPageState createState() => _OnPlayingPageState();
}

class _OnPlayingPageState extends State<OnPlayingListPage>
    with TickerProviderStateMixin {
  bool isSelected = false;
  final FlutterAudioQuery audioQuery = FlutterAudioQuery();
  double currentMusicPosition = 0;
  List<SongInfo> songs;
  SongInfo selectedSong;

  @override
  void initState() {
    isSelected = false;
    currentMusicPosition = 0;
    selectedSong = null;
    getSongs();
    super.initState();
  }

  getSongs() async {
    print('here');
    var s = await audioQuery.getSongs();
    setState(() {
      songs =s;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xFFACC4EF), Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  "SKIN - FLUME",
                  style: TextStyle(
                    color: Color(0xFF9A97B4),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  NeumorphicCircle(
                    border: 4,
                    width: 50,
                    height: 50,
                    child: Icon(
                      Icons.favorite,
                      color: Color(0xFF9A97B4),
                      size: 25,
                    ),
                  ),
                  NeumorphicCircle(
                    width: MediaQuery.of(context).size.width / 3,
                    height: MediaQuery.of(context).size.width / 3,
//                        child: Image.asset(selectedSong.filePath),
                  ),
                  NeumorphicCircle(
                    border: 4,
                    width: 50,
                    height: 50,
                    child: Icon(
                      Icons.more_horiz,
                      color: Color(0xFF9A97B4),
                      size: 25,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Expanded(
                child: ShaderMask(
                  blendMode: BlendMode.dstIn,
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[Colors.white, Colors.transparent],
                    ).createShader(bounds);
                  },
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: songs != null
                            ? songs
                                .map(
                                  (s) => OnPlayingListTile(
                                    isSelected: selectedSong == s,
                                    songInfo: s,
                                    onPlayed: (){
                                      setState(() {
                                        selectedSong =s;
                                      });
                                    },
                                    onPaused: (){
                                      setState(() {
                                        selectedSong =null;
                                      });
                                    },
                                  ),
                                )
                                .toList()
                            : []),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
