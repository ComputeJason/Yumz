import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:yumzapp/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yumzapp/screens/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:yumzapp/recipe.dart';

class AddRecipe extends StatefulWidget {
  static const String route = 'addRecipe';

  @override
  _AddRecipeState createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  List _items = [];
  Widget buildBottomSheet(BuildContext context) {
    return Container(child: Center(child: Text('hello')));
  }

  List<IngredientTag> ingredientTagsList = [];
  List<IngredientMeasurement> ingredientMeasurementList = [];
  List<Step> stepsList = [];

  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  TextEditingController _controller4 = TextEditingController();
  TextEditingController _controller5 = TextEditingController();

  String newTag;
  String newAmt;
  String newUnit;
  String newName;
  String newStep;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 10.0, left: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          CupertinoIcons.reply_thick_solid,
                          color: kIconOrButtonColor,
                          size: 34,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      kSmallGap,
                      Container(
                        child: Text(
                          'Add Recipe',
                          style: kPageHeading,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      SizedBox(
                        width: 200.0,
                        child: TextField(
                          decoration: const InputDecoration(
                            labelText: 'RECIPE NAME',
                            labelStyle: kAddHeading,
                            hintText: 'add recipe name',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      GestureDetector(
                        //TODO: add photo for onTap:
                        child: Container(
                          width: 100.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            color: kHeading,
                          ),
                          child: Center(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  child: Icon(CupertinoIcons.add),
                                ),
                                Text('Add photo'),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 200.0,
                        child: TextField(
                          decoration: const InputDecoration(
                            labelText: 'DESCRIPTION',
                            labelStyle: kAddHeading,
                            hintText: 'add description',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                kSizedBox,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  width: double.infinity,
                  decoration: kRoundedCard,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      kSizedBox,
                      Container(child: Text('DIFFICULTY', style: kAddHeading)),
                      RatingBar(
                        initialRating: 0,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                      kSizedBox,
                      Container(child: Text('DURATION', style: kAddHeading)),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: 35.0,
                            child: TextField(textAlign: TextAlign.center),
                          ),
                          Container(child: Text(' hr ')),
                          SizedBox(
                            width: 35.0,
                            child: TextField(textAlign: TextAlign.center),
                          ),
                          Container(child: Text(' min ')),
                        ],
                      ),
                      kSizedBox,
                      Container(child: Text('ADD TAGS', style: kAddHeading)),
                      Wrap(
                        direction: Axis.horizontal,
                        children: ingredientTagsList,
                      ),
                      Row(
                        children: <Widget>[ 
                          Expanded(
                            child: TextField(
                              controller: _controller1,
                            autofocus: true,
                            textAlign: TextAlign.center,
                            onChanged: (newInput){
                              newTag = newInput;
                            },
                        ),
                          ),
                          FlatButton(onPressed: (){
                            setState(() {
                              ingredientTagsList.add(IngredientTag(newTag));
                              _controller1.clear();
                            });
                          }, child: Text('add'), color: kHeading)
                      ],),                    
                      kSizedBox,
                      Container(
                          child: Text('ADD INGREDIENTS', style: kAddHeading)),
                      Column(
                        children: ingredientMeasurementList,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(hintText: 'amount'),
                              controller: _controller2,
                              autofocus: true,
                              textAlign: TextAlign.center,
                              onChanged: (newInput){
                                newAmt = newInput;
                              },
                            ),
                          ),
                          SizedBox(width: 5.0,),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(hintText: 'unit'),
                              controller: _controller3,
                              autofocus: true,
                              textAlign: TextAlign.center,
                              onChanged: (newInput){
                                newUnit = newInput;
                              },
                            ),
                          ),
                          SizedBox(width: 5.0,),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(hintText: 'ingredient'),
                              controller: _controller4,
                              autofocus: true,
                              textAlign: TextAlign.center,
                              onChanged: (input){
                                newName = input;
                              },
                            ),
                          ),
                          SizedBox(width: 5.0,),
                          FlatButton(onPressed: (){
                            setState(() {
                              ingredientMeasurementList.add(IngredientMeasurement(newAmt, newUnit, newName));
                              _controller2.clear();
                              _controller3.clear();
                              _controller4.clear();

                            });
                          }, child: Text('add'), color: kHeading)
                        ],),
                      kSizedBox,
                      Container(child: Text('ADD STEPS', style: kAddHeading)),
                      Column(
                        children: stepsList,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(hintText: 'add steps...'),
                              controller: _controller5,
                              autofocus: true,
                              textAlign: TextAlign.center,
                              onChanged: (newInput){
                                newStep = newInput;
                              },
                            ),
                          ),
                          SizedBox(width: 5.0,),
                          FlatButton(onPressed: (){
                            setState(() {
                              stepsList.add(Step(newStep, stepsList.length));
                              _controller5.clear();
                            });
                          }, child: Text('add'), color: kHeading)
                        ],),
                      kSizedBox,
                      Center(
                        child: GestureDetector(
                          //TODO: add photo for onTap:
                          child: Container(
                            width: 100.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              color: kIconOrButtonColor,
                            ),
                            child: Center(
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    child: Icon(CupertinoIcons.add),
                                  ),
                                  Text('Add Recipe'),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      kSizedBox,
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class IngredientTag extends StatelessWidget {
  IngredientTag(this.name);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: kHeading,
      label: Text(name),
      deleteIcon: Icon(CupertinoIcons.clear_thick_circled),
      onDeleted: (){}, //TODO: deleting tags
    );
  }
}

class Step extends StatelessWidget {
  Step(this.stepName, this.stepNum);

  final String stepName;
  final int stepNum;

  @override
  Widget build(BuildContext context) {
    String input = (stepNum+1).toString() + '. ' + stepName;
    return Chip(
      backgroundColor: kHeading,
      label: Text(input),
      deleteIcon: Icon(CupertinoIcons.clear_thick_circled),
      onDeleted: (){}, //TODO: deleting tags
    );
  }
}

class IngredientMeasurement extends StatelessWidget {
  IngredientMeasurement(this.amt, this.unit, this.name);

  final String amt;
  final String unit; //TODO: extra, create drop down for units?
  final String name;

  @override
  Widget build(BuildContext context) {
    String input = amt + ' ' + unit +  ' ' + name;
    return Chip(
      backgroundColor: kHeading,
      label: Text(input),
      deleteIcon: Icon(CupertinoIcons.clear_thick_circled),
      onDeleted: (){}, //TODO: deleting tags
    );
  }
}

class RoundIconButton extends StatelessWidget {
  RoundIconButton({@required this.icon, @required this.onPressed});

  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 0.0,
      child: Icon(icon, color: kBackgroundColor),
      onPressed: onPressed,
      constraints: BoxConstraints.tightFor(
        width: 25.0,
        height: 25.0,
      ),
      shape: CircleBorder(),
      fillColor: kIconOrButtonColor,
    );
  }
}
