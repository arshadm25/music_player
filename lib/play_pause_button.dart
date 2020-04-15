import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer/neumorphic_circle.dart';

class PlayPauseButton extends StatefulWidget{
  final VoidCallback onPlayed;
  final VoidCallback onPaused;
  final double width;
  final double height;
  final double border;
  final bool isPlaying;

  const PlayPauseButton({Key key,@required this.onPlayed,@required this.onPaused, this.width, this.height, this.border, this.isPlaying:false,}) : super(key: key);

  @override
  _PlayPauseButtonState createState() => _PlayPauseButtonState();
}

class _PlayPauseButtonState extends State<PlayPauseButton> with SingleTickerProviderStateMixin{
  AnimationController playPauseAnimationController;

  @override
  void initState() {
    playPauseAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    super.initState();
    if(widget.isPlaying){
      playPauseAnimationController.reverse();
    }else{
      playPauseAnimationController.forward();
    }
  }


  @override
  void dispose() {
    playPauseAnimationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(widget.isPlaying){
          widget.onPaused();
          playPauseAnimationController.reverse();
        }else{
          widget.onPlayed();
          playPauseAnimationController.forward();
        }
      },
      child: NeumorphicCircle(
        width: widget.width,
        height: widget.height,
        border: widget.border,
        isSelected: widget.isPlaying,
        child:Center(
          child: AnimatedIcon(
            size: widget.height/2,
              progress: playPauseAnimationController,
              color: !widget.isPlaying?Color(0xFF9A97B4):Colors.white,
              icon:AnimatedIcons.play_pause
          ),
        )
      ),
    );
  }

}