import 'package:flutter/material.dart';
import 'package:yumzapp/constants.dart';
import 'home.dart';

class Login extends StatefulWidget {
  static const String route = 'login';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 5),
            child: ClipRect(
              child: Container(
                child: Align(
                  alignment: Alignment.center,
                  widthFactor: 0.6,
                  heightFactor: 0.6,
                  child: Image.asset(
                    'images/yumzDrawing.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
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
                Navigator.pushNamed(context, Home.route);
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
