import 'package:flutter/material.dart';

class ColorData extends ChangeNotifier{

  ColorData({this.choosenNum});

  int choosenNum = 0;

  void changeNum(int newNum){
    choosenNum = newNum;
    notifyListeners();
  }

  bool isMe(int num, int index){
    return num == index;
  }
}