import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yumzapp/screens/edit_profile.dart';
import 'package:yumzapp/screens/home.dart';
import 'package:yumzapp/screens/login.dart';
import 'package:flutter/material.dart';
import '../recipe.dart';
import '../constants.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Profile extends StatefulWidget {

  static const String route = 'profile';

  @override
  _ProfileState createState() => _ProfileState();
}


class _ProfileState extends State<Profile> {

  final _store = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  String username = '';
  String bio = '';
  String downloadProfilePicUrl;


  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  //displaying the Bio,Username on entering page from fireStore
  void getCurrentUser() async {
    try{
      final user = await _auth.currentUser();
      if(user != null){
        loggedInUser = user;
        String email = loggedInUser.email;
        var result = await _store.collection('users').where('email' , isEqualTo: loggedInUser.email).getDocuments();
        result.documents.forEach((res){
          if(!res['username'].isEmpty){
            print('hello');
            setState(() {
              username = res['username'];
            });
          } else {
            print('bye');
            setState(() {
              username = email.substring(0,email.indexOf('@'));
            });
          }

          if(!res['bio'].isEmpty){
            setState(() {
              bio = res['bio'];
            });
          }
        });

      }
    } catch (e){
      print(e);
    }
    print('Fetched current user');
    downloadProfilePic();
  }

  void downloadProfilePic() async{
    try{
      StorageReference reference = FirebaseStorage.instance.ref().child('${loggedInUser.email}.jpg');
      String downloadAddress = await reference.getDownloadURL();
      setState(() {
        downloadProfilePicUrl = downloadAddress;
      });
    } catch(e){
      print(e);
      setState(() {
        downloadProfilePicUrl = 'https://st2.depositphotos.com/6759912/11383/i/950/depositphotos_113833926-stock-photo-sandwich-burger-on-white-background.jpg';
      });
    }
    print('Fetched profile pic');
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.reply_thick_solid,
            color: kIconOrButtonColor,
            size: 34,
          ),
          tooltip: 'Log Out',
          onPressed: (){
            _auth.signOut();
            Navigator.pushNamed(context, Login.route);
          },
        ),
        title: Text(
          'Profile',
          style: TextStyle(
            fontFamily: 'Playball',
            fontSize: 30,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              icon: Icon(Icons.home, size: 34, color: kIconOrButtonColor,),
              onPressed: (){
                Navigator.pushNamed(context, Home.route);
              },
              tooltip: "Homepage",
              ),
            ),
        ],
      ),

      //add recipe button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){},
        backgroundColor: kIconOrButtonColor,
        icon: Icon(Icons.add),
        label: Text(
          'Recipe',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),


      //body
      body: Column(
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: CircleAvatar(
                radius: 60,
                backgroundImage: downloadProfilePicUrl == null ? null : NetworkImage(downloadProfilePicUrl),
                backgroundColor: Color(0xFFA7ACA7),
              ),
            ),
          ),

          //username
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: Text(
              username,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          //bio
          Container(
            child: Center(
              child: Text(
                bio,
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            height: 70,
            width: 300,
            color: Color(0xFFECE8E5),
          ),

          Container(
            padding: EdgeInsets.only(top: 5),
            width: 300,
            height: 30,
            child: OutlineButton(
              color: Colors.grey,
              onPressed: (){
                Navigator.push(context , MaterialPageRoute(builder: (context){
                  return EditProfile(user: loggedInUser, url: downloadProfilePicUrl);
                }),);
              },
              child: Text('Edit Profile', style: TextStyle(fontSize: 13),),
              borderSide: BorderSide(
                color: Colors.black.withOpacity(0.2),
                width: 0.8,
              ),
              highlightedBorderColor: Colors.grey,
            ),
          ),

          //divider
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SizedBox(
              width: 500,
              height: 5,
              child: Divider(
                color: Color(0xFF5F6368),
                thickness: 2,
              ),
            ),
          ),
          SizedBox(
            width: 500,
            height: 5,
            child: Divider(
              color: Color(0xFF5F6368),
              thickness: 2,
            ),
          ),

          //Recipe heading
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[

              //'Recipes' Text
              Padding(
                padding: const EdgeInsets.only(top: 7, bottom: 5),
                child: Text(
                  'RECIPES',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1,
                  ),
                ),
              ),
              SizedBox(
                width: 200,
              ),
            ],
          ),

          //for list
          Expanded(
            child: Container(
              child: _buildContent(),
            ),
          ),
        ],
      ),
    );
  }


  //listview builder
  Widget _buildContent() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        Recipe recipe = recipes[index];
        return Column(
          children: <Widget>[
            Container(
              color: Color(0xFFD9C38A),
              child: RecipeListTile(recipe),
            ),
            Divider(
              height: 2,
              thickness: 1,
              color: Colors.white,
            ),
          ],
        );
      },
      itemCount: 25,
    );
  }
}

  //listtile content
  class RecipeListTile extends ListTile{
    RecipeListTile(Recipe recipe)
    : super(
      title: Text(recipe.recipeName, style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
      subtitle: Text(recipe.recipeDescription),
      leading: Icon(Icons.fastfood),
    );
  }

  //list contents for now
  List<Recipe> recipes = [
    Recipe(recipeName: 'cheesecake', recipeDescription: 'a delicious cake cheesy cake that is easy to make'),
    Recipe(recipeName: 'orangecake', recipeDescription: 'a tangy delicacy made from orange skins'),
    Recipe(recipeName: 'mushroom soup', recipeDescription: 'best to drink during a cold rainy day'),
    Recipe(recipeName: 'tomatocake', recipeDescription: 'a weird cake yet satisfying pastry to bake'),
    Recipe(recipeName: 'onioncake', recipeDescription: 'something out of the box you have not tried before'),
    Recipe(recipeName: 'orangecake', recipeDescription: 'a tangy delicacy made from orange skins'),
    Recipe(recipeName: 'mushroom soup', recipeDescription: 'best to drink during a cold rainy day'),
    Recipe(recipeName: 'tomatocake', recipeDescription: 'a weird cake yet satisfying pastry to bake'),
    Recipe(recipeName: 'onioncake', recipeDescription: 'something out of the box you have not tried before'),
    Recipe(recipeName: 'orangecake', recipeDescription: 'a tangy delicacy made from orange skins'),
    Recipe(recipeName: 'mushroom soup', recipeDescription: 'best to drink during a cold rainy day'),
    Recipe(recipeName: 'tomatocake', recipeDescription: 'a weird cake yet satisfying pastry to bake'),
    Recipe(recipeName: 'onioncake', recipeDescription: 'something out of the box you have not tried before'),
    Recipe(recipeName: 'cake', recipeDescription: 'a'),
    Recipe(recipeName: 'bread', recipeDescription: 'b'),
    Recipe(recipeName: 'cake', recipeDescription: 'c'),
    Recipe(recipeName: 'bread', recipeDescription: 'd'),
    Recipe(recipeName: 'cake', recipeDescription: 'e'),
    Recipe(recipeName: 'bread', recipeDescription: 'f'),
    Recipe(recipeName: 'cake', recipeDescription: 'g'),
    Recipe(recipeName: 'bread', recipeDescription: 'h'),
    Recipe(recipeName: 'cake', recipeDescription: 'i'),
    Recipe(recipeName: 'bread', recipeDescription: 'j'),
    Recipe(recipeName: 'bread', recipeDescription: 'j'),
    Recipe(recipeName: 'bread', recipeDescription: 'j'),
    Recipe(recipeName: 'bread', recipeDescription: 'j'),
    Recipe(recipeName: 'bread', recipeDescription: 'j'),
    Recipe(recipeName: 'bread', recipeDescription: 'j'),



  ];

//jason sucks


















