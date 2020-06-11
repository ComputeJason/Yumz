import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yumzapp/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yumzapp/screens/profile.dart';

class EditProfile extends StatefulWidget {

  static const String route = 'editProfile';
  final FirebaseUser user;

  //pass in the User from the ProfilePage
  EditProfile({this.user});

  @override
  _EditProfileState createState() => _EditProfileState();
}


class _EditProfileState extends State<EditProfile> {

  final _store = Firestore.instance;
  String route = 'editProfile';

  String bio = '';
  bool bioChanged = false; //check if bio field was touched
  String username = '';
  bool usernameChanged = false; //check if username field was touched

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      //mainly the back button
      appBar: AppBar(
        backgroundColor: kRandomBlockGrey,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 30,
            ),
            onPressed: () {
              Navigator.pushNamed(context, Profile.route);
            }),
      ),

      //body for TextFields & buttons
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text('Change Username:'),
          TextField(
            decoration: InputDecoration(
              hintText: 'new username',
            ),
            onChanged: (value) {
              username = value;
              usernameChanged = true;
            },
          ),
          Text('Change Bio'),
          TextField(
            decoration: InputDecoration(
              hintText: "I like cooking because....."
            ),
            onChanged: (value) {
              bio = value;
              bioChanged = true;
            },
          ),
          FlatButton(
            color: kIconOrButtonColor,
            onPressed: () {},
            child: Text('Change Profile Picture'),
          ),

          //logic for all the updating of the fireStore data
          RaisedButton(
            color: kRandomBlockGrey,
            onPressed: () {

              //if nvr touch any textfields --> pop back to profile
              if (!bioChanged && !usernameChanged) {
                Navigator.pop(context);

              //if the textfields were changed --> show pop for saving
              } else {
                showCupertinoDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CupertinoAlertDialog(
                      title: Text('Do you want to save these changes?'),
                      actions: <Widget>[
                        CupertinoDialogAction(
                          child: FlatButton(
                            child: Text('Yes'),
                            //if YES ,save changes into fireStore and go back to profile page
                            onPressed: () {
                              //if only username textfield was changed
                              if (bioChanged && !usernameChanged) {
                                _store
                                    .collection('users')
                                    .document(widget.user.email)
                                    .updateData({
                                  'bio': bio,
                                });
                              //if only bio textfield was changed
                              } else if (!bioChanged && usernameChanged) {
                                _store
                                    .collection('users')
                                    .document(widget.user.email)
                                    .updateData({
                                  'username': username,
                                });
                              //if both textfields were changed
                              } else if (bioChanged && usernameChanged) {
                                _store
                                    .collection('users')
                                    .document(widget.user.email)
                                    .updateData({
                                  'username': username,
                                  'bio': bio,
                                });
                              }
                              //at the end push back to profile page w changes made
                              Navigator.pushNamed(context, Profile.route);
                            },
                          ),
                        ),

                        //if NO, just close the pop-up and let them try again
                        CupertinoDialogAction(
                          child: FlatButton(
                            child: Text('No'),
                            onPressed: (){
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}
