import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

const Color kBackgroundColor = Color(0xFFE9D8D2);
const Color kAppBarColor = Color(0xFFB1B7BF);
const Color kIconOrButtonColor = Color(0xFF507E5C);
const Color kRandomBlockGrey = Color(0xFFA7ACA7);
const Color kDarkGrey = Color(0xFF696969);
const Color kHeading = Color(0xFFD07C59);

const Widget kSizedBox = SizedBox(height: 20.0,);
const Widget kSmallGap = SizedBox(height: 10.0,);

const TextStyle kAddHeading = TextStyle(
  fontWeight: FontWeight.w900,
  color: kDarkGrey,
);

const TextStyle kPageHeading = TextStyle(
fontWeight: FontWeight.w900, color: kHeading, fontSize: 30.0,);

const BoxDecoration kRoundedCard = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(20.0),
    topRight: Radius.circular(20.0),
  ),
);


/* const Container kSearchWidget = Container(
  padding: EdgeInsets.only(left: 25.0, right: 25.0),
  height: 45.0,
  child: Center(
    child: Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: Icon(
            Icons.search,
            color: Colors.black26,
            size: 20.0,
          ),
        ),
        Expanded(
            child: TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '想喝点什么？',
                  hintStyle: TextStyle(color: Colors.black26)),
              cursorColor: Theme.of(this.context).accentColor,
              onChanged: (value) {
                _doSearch(value);
              },
            ))
      ],
    ),
  ),
); */