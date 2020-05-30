import 'package:flutter/material.dart';
import '../recipe.dart';
import '../constants.dart';


class Profile extends StatefulWidget {

  static const String route = 'profile';

  @override
  _ProfileState createState() => _ProfileState();
}


class _ProfileState extends State<Profile> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        leading: Icon(
          Icons.home,
          color: kIconOrButtonColor,
          size: 34,
        ),
        title: Text(
          'Profile',
          style: TextStyle(
            fontFamily: 'Playball',
            fontSize: 30,
          ),

        ),
      ),
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
      body: Column(
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTSuwQMMkXfazsQYA4y9eTYucjzq_Z1wicZYGIvgxw2bJnA9H6r&usqp=CAU'),
                backgroundColor: Color(0xFFA7ACA7),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: Text(
              '@CheesuCake',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            child: Center(
              child: Text(
                'Hi everyone! My name is Cheesu and I really love cooking! Im here to share some of my original recipes that are super easy to make and super delicious to EATT! :D',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            height: 100,
            width: 300,
            color: Color(0xFFECE8E5),
          ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
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
          Expanded(
            child: Container(
              child: _buildContent(),
            ),
          ),
        ],
      ),
    );
  }

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
  class RecipeListTile extends ListTile{
    RecipeListTile(Recipe recipe)
    : super(
      title: Text(recipe.recipeName, style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
      subtitle: Text(recipe.recipeDescription),
      leading: Icon(Icons.fastfood),
    );
  }

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


















