import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: Row(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: (){},
              child: Container(
                child: Text(
                  'search here...',
                  style: TextStyle(
                    color: Colors.blueGrey[800],
                    fontWeight: FontWeight.w900,),),
                margin: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.blueGrey[400],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
