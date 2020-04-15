import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:musicplayer/on_playing_page.dart';
import 'package:musicplayer/play_pause_button.dart';

class OnPlayingListTile extends StatelessWidget{
  final bool isSelected;
  final SongInfo songInfo;
  final VoidCallback onPaused;
  final VoidCallback onPlayed;

  const OnPlayingListTile({Key key, this.isSelected:false,this.songInfo, this.onPaused, this.onPlayed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context){
            return OnPlayingPage(
              songInfo: songInfo,
            );
          }
        ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            padding: EdgeInsets.all(8),
            decoration: isSelected?BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10),),
                color: Color(0xFFACC4EF)
            ):null,
            child: _generateInnerContent()
        )
      ),
    );
  }

  _generateInnerContent(){
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(this.songInfo.displayName,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color(0xFF9A97B4),
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),),
                Text(this.songInfo.album,style: TextStyle(
                    color: Color(0xFF9A97B4),
                    fontSize: 12,
                    fontWeight: FontWeight.normal
                ),),
              ],
            ),
          ),
          PlayPauseButton(
            width: 40,
            isPlaying: isSelected,
            height: 40,
            border: 3,
            onPaused:onPaused,
            onPlayed:onPlayed ,
          )
        ],
      ),
    );
  }

}