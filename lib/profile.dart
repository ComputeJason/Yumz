import 'package:flutter/material.dart';
import 'recipe.dart';


class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}


class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE9D8D2),
      appBar: AppBar(
        backgroundColor: Color(0xFFB1B7BF),
        leading: Icon(
          Icons.home,
          color: Color(0xFF507E5C),
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
        backgroundColor: Color(0xFF507E5C),
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
              '@Username',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Container(
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
//              FloatingActionButton(
//                backgroundColor: Color(0xFF507E5C),
//                child: Icon(
//                  Icons.add,
//                  color: Colors.white,
//                ),
//              ),
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
      itemCount: 14,
    );
  }
}
  class RecipeListTile extends ListTile{
    RecipeListTile(Recipe recipe)
    : super(
      title: Text(recipe.recipeName),
      subtitle: Text(recipe.recipeDescription),
      leading: Icon(Icons.fastfood),
    );
  }

  List<Recipe> recipes = [
    Recipe(recipeName: 'cheesecake', recipeDescription: 'a delicious cake'),
    Recipe(recipeName: 'orangecake', recipeDescription: 'a sourer cake'),
    Recipe(recipeName: 'tomatocake', recipeDescription: 'a weird cake'),
    Recipe(recipeName: 'onioncake', recipeDescription: 'what is this??'),
    Recipe(recipeName: 'a', recipeDescription: 'a'),
    Recipe(recipeName: 'b', recipeDescription: 'b'),
    Recipe(recipeName: 'c', recipeDescription: 'c'),
    Recipe(recipeName: 'd', recipeDescription: 'd'),
    Recipe(recipeName: 'e', recipeDescription: 'e'),
    Recipe(recipeName: 'f', recipeDescription: 'f'),
    Recipe(recipeName: 'g', recipeDescription: 'g'),
    Recipe(recipeName: 'h', recipeDescription: 'h'),
    Recipe(recipeName: 'i', recipeDescription: 'i'),
    Recipe(recipeName: 'j', recipeDescription: 'j'),

  ];

//jason sucks


















