import 'package:flutter/material.dart';
import 'package:yumzapp/constants.dart';
import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //just delete this below and add some logo or something to make it look lit up to u :D
          Text(
            'INSERT LOGO HERE PATCHA',
            style: TextStyle(fontSize: 40),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Sign in   |   Sign up',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 5, left: 73),
                child: Text(
                  'USERNAME',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: 360,
            child: TextField(
              decoration: InputDecoration(
                fillColor: kRandomBlockGrey,
                filled: true,
                hintText: 'Enter your username',
                icon: Icon(
                  Icons.people,
                  color: kIconOrButtonColor,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              onChanged: (value) {},
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 5, left: 73),
                child: Text(
                  'PASSWORD',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: 360,
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: kRandomBlockGrey,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                hintText: 'Enter your password',
                icon: Icon(
                  Icons.lock,
                  color: kIconOrButtonColor,
                ),
              ),
              onChanged: (value) {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 35),
            child: FlatButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
              },
              child: Container(
                child: Text(
                  'Sign in',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              color: kIconOrButtonColor,
            ),
          ),
        ],
      ),
    );
  }
}
