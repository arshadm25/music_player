import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NeumorphicCircle extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;
  final double border;
  final bool isSelected;

  const NeumorphicCircle(
      {Key key, this.width: 100, this.height: 100, this.child,this.border:5,this.isSelected:false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(color: isSelected?Color(0xFF547dff).withOpacity(0.8):Color(0XFFACC4EF).withOpacity(0.5), width: border),
          boxShadow: [
            BoxShadow(
                offset: Offset(10, 10),
                blurRadius: 16,
                color: Color(0XFF352351).withOpacity(.2),
            ),
            BoxShadow(
                offset: Offset(-10, -10),
                blurRadius: 16,
                color: Colors.white.withOpacity(.3),
            )
          ],
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                focalRadius: height/2,

                colors: isSelected?[
                  Color(0xFF547dff).withOpacity(0.4),
                  Color(0xFF547dff).withOpacity(0.6),
                  Color(0xFF547dff).withOpacity(0.8),
                ]:[
                  Color(0xFFACC4EF).withOpacity(.2),
                  Colors.white
                ]
              )
            ),
            child: child
        ),
    );
  }
}
