import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LetsDo extends StatefulWidget {

  static String route = '/letsdo';

  @override
  _LetsDoState createState() => _LetsDoState();
}

class _LetsDoState extends State<LetsDo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF752626),
      body: Stack(
        children: <Widget>[

          //Main tile

          Positioned(
            top: 50,
            left: 0,
            child: Container(
              height: 620,
              width: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight:Radius.circular(20),bottomRight: Radius.circular(20), ),
                gradient: LinearGradient(
                  colors: [Color(0xFFff7458),Color(0xFFfb3c43),],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(5,5),
                    blurRadius: 5,
                    color: Colors.black
                  ),
                ],
              ),

              //Items on the main tile

              child: Stack(
                children: <Widget>[

                  //Edit button
                  Positioned(
                    right:30,
                    top: 23,
                    child: FloatingActionButton(
                      elevation: 50,
                      onPressed: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                              ),
                              child: Container(
                                height: 120,
                                width: 200,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0,1),
                                      color: Colors.black,
                                      blurRadius: 3,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    TextField(
                                      decoration: InputDecoration(
                                        hintText: 'new task',
                                        focusColor: Colors.redAccent,
                                      ),
                                      textAlign: TextAlign.center,
                                      autofocus: true,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                                      child: RaisedButton(
                                        padding: EdgeInsets.all(8),
                                        onPressed: (){
                                          Navigator.pop(context);
                                        },
                                        child: Text('Add new task'),
                                        color: Color(0xFFfc9f92),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.edit,
                        size: 30,
                        color: Color(0xFFfb3c43),
                      ),
                    ),
                  ),


                  //DO IT text
                  Positioned(
                    top: 15,
                    left: 10,
                    child: Text(
                      'Do It.',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 60,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            offset: Offset(1,1),
                            color: Colors.black,
                            blurRadius: 4,
                          )
                        ],
                      ),
                    ),
                  ),


                  //Big white seperator
                  Positioned(
                    top: 100,
                    child: Container(
                      width: 400,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0,3),
                            color: Colors.black,
                            blurRadius:4 ,
                          )
                        ],
                      ),
                    ),
                  ),


                  //ListView checklist
                  Positioned(
                    top: 100,
                    left: 0,
                    child: Container(
                      height: 550,
                      width: 350,
                      child: ListView(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ListTile(
                                title: Text(
                                  'Finish 2040 lab',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                ),
                                trailing: Icon(FontAwesomeIcons.circle),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                height: 0.6,
                                width: 250,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0,1),
                                      color: Colors.black,
                                      blurRadius: 1,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[


                              ListTile(
                                title: Text(
                                  'Finish 2040 lab',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                ),
                                trailing: Icon(FontAwesomeIcons.circle),
                              ),


                              Container(
                                alignment: Alignment.centerLeft,
                                height: 0.6,
                                width: 250,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0,1),
                                      color: Colors.black,
                                      blurRadius: 1,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ListTile(
                                title: Text(
                                  'Finish 2040 lab',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: Icon(FontAwesomeIcons.circle),
                                  onPressed: (){
                                    setState(() {

                                    });
                                  },
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                height: 0.6,
                                width: 250,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0,1),
                                      color: Colors.black,
                                      blurRadius: 1,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          //Calendar tile

          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft:Radius.circular(20), ),
                gradient: LinearGradient(
                  colors: [Color(0xFFff7458),Color(0xFFfb3c43),],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(-8,-8),
                      blurRadius: 5,
                      color: Colors.black
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Icon(FontAwesomeIcons.solidCalendarAlt, size: 50,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 15,),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Calendar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
