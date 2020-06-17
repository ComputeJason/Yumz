import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:letsapp/screens/letsCatchup.dart';
import 'package:provider/provider.dart';
import 'package:letsapp/forDressup/ColorData.dart';
import 'package:letsapp/forDressup/closet.dart';
import 'package:letsapp/screens/letsGo.dart';
import 'package:letsapp/screens/letsDo.dart';

Color focusColor = Color(0xFFc6f4f5);
Color blurColor = Colors.blueGrey.shade400.withOpacity(0.3);

class LetsDressup extends StatefulWidget {
  static String route = '/letsdressup';

  @override
  _LetsDressupState createState() => _LetsDressupState();
}


class _LetsDressupState extends State<LetsDressup> {

  Widget screen = DressupContainer();

  Widget drawerTile(Color tileColor, String name, Widget widget){
    return Container(
      color: tileColor,
      child: ListTile(
        onTap: (){
          setState(() {
            Navigator.pop(context);
            screen = widget;
          });
        },
        title: Text(name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 17),),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ChangeNotifierProvider<ColorData>(
          create: (context) => ColorData(),
          builder: (context, child) {
            return Scaffold(
              drawer: Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: Color(0xFFebebeb),
                ),
                child: Drawer(
                  elevation: 50,
                  child: ListView(
                    children: <Widget>[
                      UserAccountsDrawerHeader(
                        currentAccountPicture: CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('images/Jasonface0.JPG'),
                        ),
                        accountName: Text('Jason Chen', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        accountEmail: Text('Software Developer'),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage('https://scx1.b-cdn.net/csz/news/800/2019/4-space.jpg'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      drawerTile(Color(0xFF585a75), 'LetsDressUp', DressupContainer()),
                      drawerTile(Color(0xFF171b61), 'LetsGo', LetsGo()),
                      drawerTile(Color(0xFF306e52), 'LetsCatchUp', LetsCatchup()),
                      drawerTile(Color(0xFF752626), 'LetsDo', LetsDo()),
                    ],
                  ),
                ),
              ),
              body: screen,
            );
          }),
    );
  }
}

class DressupContainer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        gradient: LinearGradient(
          colors: [
            Colors.grey.shade300,
            Colors.grey.shade800,
            Colors.white
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Closet(
                      icon: Icon(
                        FontAwesomeIcons.snowflake,
                        size: 80,
                      ),
                      index: 1,
                      style: 'Chillax',
                      checker:
                          Provider.of<ColorData>(context).choosenNum,
                      outfitURL: 'https://static.fashionbeans.com/wp-content/uploads/2018/08/modern-shorts-look-3.jpg',
                    ),
                    Closet(
                      icon: Icon(
                        Icons.airline_seat_individual_suite,
                        size: 80,
                      ),
                      index: 2,
                      style: 'Lupsup',
                      checker:
                          Provider.of<ColorData>(context).choosenNum,
                      outfitURL: 'https://www.pjpan.co.uk/media/catalog/product/cache/ddc9bd1b85fcfa71e5e91929f8504b46/m/e/mens-quality-pyjamas-2.jpg',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Closet(
                      icon: Icon(
                        FontAwesomeIcons.glassMartini,
                        size: 80,
                      ),
                      index: 3,
                      style: 'Smort Casual',
                      checker:
                          Provider.of<ColorData>(context).choosenNum,
                      outfitURL:'https://images.squarespace-cdn.com/content/v1/543b99e5e4b0322c11479d13/1562159949563-0DDCWB8LARRPI2UW9HEQ/ke17ZwdGBToddI8pDm48kCiC6x0kNpxliGpzQTkOLNUUqsxRUqqbr1mOJYKfIPR7LoDQ9mXPOjoJoqy81S2I8PaoYXhp6HxIwZIk7-Mi3Tsic-L2IOPH3Dwrhl-Ne3Z2ppk8fIk4OUdzzAJ58dNz9ksAnbOUWC6fgQEHg0Bz14hkOpdljO7Z-5qh0zg85Jnj/casual-friday-men-20-of-20.jpg' ,
                    ),
                    Closet(
                      icon: Icon(
                        FontAwesomeIcons.blackTie,
                        size: 80,
                      ),
                      index: 4,
                      style: 'Formal Sexy',
                      checker:
                          Provider.of<ColorData>(context).choosenNum,
                      outfitURL: 'https://sc02.alicdn.com/kf/HTB1qhoDgkUmBKNjSZFOq6yb2XXaU.jpg',
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
          Center(
            child: CircleAvatar(
              backgroundImage: Provider.of<ColorData>(context).choosenNum == null ? AssetImage('images/Jasonface0.JPG') :  AssetImage('images/Jasonface${Provider.of<ColorData>(context).choosenNum}.JPG'),
              radius: 80,
            ),
          ),
        ],
      ),
    );
  }
}


