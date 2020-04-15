import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:musicplayer/play_pause_button.dart';
import 'custom_thum_shape.dart';
import 'neumorphic_circle.dart';

class OnPlayingPage extends StatefulWidget {
  final SongInfo songInfo;

  OnPlayingPage({Key key, this.songInfo}) : super(key: key);

  @override
  _OnPlayingPageState createState() => _OnPlayingPageState();
}

class _OnPlayingPageState extends State<OnPlayingPage>  with TickerProviderStateMixin{
  bool isPlaying = false;
  double currentMusicPosition = 0;

  @override
  void initState() {
    isPlaying = false;
    currentMusicPosition = 0;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.songInfo.albumArtwork);
    return Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color(0xFFACC4EF),
                    Colors.white
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
              )
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      NeumorphicCircle(
                        border: 3,
                        width: 40,
                        height: 40,
                        child: Icon(Icons.arrow_back,color: Colors.grey,size: 18),
                      ),
                      Expanded(
                        child: Center(
                          child: Text("PLAYING NOW",style: TextStyle(
                            color: Color(0xFF9A97B4),
                            fontWeight: FontWeight.bold,
                          ),),
                        ),
                      ),
                      NeumorphicCircle(
                        border: 3,
                        width: 40,
                        height: 40,
                        child: Icon(Icons.menu,color: Colors.grey,size: 18,),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  NeumorphicCircle(
                    width: MediaQuery.of(context).size.width/1.5,
                    height: MediaQuery.of(context).size.width/1.5,
                    child: Center(child: ClipRRect(
                        borderRadius:BorderRadius.circular( MediaQuery.of(context).size.width/3 ),
                        child: widget.songInfo.albumArtwork!=null?Image.file(File(widget.songInfo.albumArtwork),fit: BoxFit.cover,width: MediaQuery.of(context).size.width/1.5,height: MediaQuery.of(context).size.width/1.5,):Text("NO Cover"))),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Column(
                    children: <Widget>[
                      Text(widget.songInfo.displayName,
                        textAlign:TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Color(0xFF9A97B4),
                          letterSpacing: .8,
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                      ),),
                      Text("Flume ft. Vic Mensa",style: TextStyle(
                          color: Color(0xFF9A97B4),
                          fontSize: 12,
                          fontWeight: FontWeight.normal
                      ),)
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  SliderTheme(
                    data: SliderThemeData(
                      thumbColor: Color(0xFF547dff),
                      thumbShape: NeumorphicRoundSliderThumbShape(
                        disabledThumbRadius: 5,enabledThumbRadius:5
                      ),
                    ),
                    child: Slider(
                      min: 0,
                      max: 100,
                      value: currentMusicPosition,
                      onChanged: (val){
                        setState(() {
                          currentMusicPosition = val;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      NeumorphicCircle(
                        border: 4,
                        width: 75,
                        height: 75,
                        child: Icon(Icons.fast_rewind,color: Color(0xFF9A97B4),size: 25,),
                      ),
                      PlayPauseButton(
                        width: 75,
                        height: 75,
                        border: 4,
                        isPlaying: isPlaying,
                        onPaused: (){
                          setState(() {
                            isPlaying = false;
                          });
                        },
                        onPlayed: (){
                          setState(() {
                            isPlaying = true;
                          });
                        },
                      ),
                      NeumorphicCircle(
                        border: 4,
                        width: 75,
                        height: 75,
                        child: Icon(Icons.fast_forward,color: Color(0xFF9A97B4),size: 25,),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}