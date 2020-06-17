import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:letsapp/forDressup/ColorData.dart';

class Closet extends StatefulWidget {
  Closet({this.icon, this.index, this.style, this.checker, this.outfitURL});

  final int index;
  final Icon icon;
  final String style;
  final checker;
  final String outfitURL;

  @override
  _ClosetState createState() => _ClosetState();
}

class _ClosetState extends State<Closet> {
  Color focusColor = Color(0xFFc6f4f5);

  double opacity;
  double opacityAnimationWholeTopCard = 1;
  double opacityAnimationOthersDisappear = 0;
  bool isMe = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onLongPress: () {
            setState(() {
              Provider.of<ColorData>(context, listen: false)
                  .changeNum(widget.index);
              isMe = true;
              opacityAnimationWholeTopCard = 0;
              opacityAnimationOthersDisappear = 1;

            });
          },
          onLongPressUp: () {
            setState(() {
              Provider.of<ColorData>(context, listen: false).changeNum(0);
              isMe = false;
              opacityAnimationWholeTopCard = 1;
              opacityAnimationOthersDisappear = 0;
            });
          },
          child: Stack(
            children: <Widget> [
              Positioned(
                top: 10,
                left: 12,
                child: Container(
                  height: 290,
                  width: 170,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 500),
                      opacity: opacityAnimationOthersDisappear,
                      child: Image(
                        image: NetworkImage(widget.outfitURL),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),

                ),
              ),
              AnimatedOpacity(
                duration: Duration(seconds: 1),
                opacity: opacityAnimationWholeTopCard,
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: widget.checker == 0
                        ? [
                      BoxShadow(
                        color: Colors.black,
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(4, 4),
                      ),
                    ]
                        : (widget.checker == widget.index
                        ? [
                      BoxShadow(
                        color: Colors.black,
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(2, 2),
                      ),
                    ]
                        : null),
                    color: widget.checker == null || widget.checker == 0
                        ? focusColor
                        : (widget.checker == widget.index
                        ? focusColor
                        : focusColor.withOpacity(0.1)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        widget.icon,
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          widget.style,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  margin: EdgeInsets.all(10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
