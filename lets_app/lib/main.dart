import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:async';
import 'package:letsapp/screens/letsCatchup.dart';
import 'package:letsapp/screens/letsDo.dart';
import 'package:letsapp/screens/letsDressup.dart';
import 'package:letsapp/screens/letsGo.dart';
import 'package:page_transition/page_transition.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute:Homepage.route,
      routes: {
        Homepage.route: (context) => Homepage(),
        LetsGo.route: (context) => LetsGo(),
        LetsDressup.route:(context) => LetsDressup(),
        LetsCatchup.route:(context) => LetsCatchup(),
        LetsDo.route:(context) => LetsDo(),
      },
    );
  }
}

class Homepage extends StatefulWidget {

  static String route = '/homepage';

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {

  int index = 0;
  AnimationController ac1;
  AnimationController ac2;
  double pageOpacity = 1;

  AnimationController scaleController;
  Animation<double> scaleAnimation;

  void engageAC1() {
    ac1.reverse(from: 1);

    ac1.addListener(() {
      setState(() {
        pageOpacity = ac1.value;
        print(ac1.value);
      });
    });
  }

  void engageAC2() {
    ac2.forward(from: 0);
    ac2.addListener(() {
      setState(() {
        pageOpacity = ac2.value;
        print(ac2.value);
      });
    });
  }

  void changeIndex() {
    setState(() {
      if (index < 2) {
        index++;
        print('if');
      } else {
        index = 0;
        print('else');
      }
    });
  }


  void changeScreen() async {
    Timer(Duration(seconds: 4), () {
      engageAC1();

      Timer(Duration(milliseconds: 600), () {
        changeIndex();
        engageAC2();
      },);

//      Timer(Duration(seconds: 2), (){
//        changeScreen();
//      },);

    });
  }

  @override
  void initState() {
    ac1 = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    ac2 = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    scaleController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    scaleController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.push(context, PageTransition(
            type: PageTransitionType.fade, child: LetsDressup()));
      }
    });

    scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 30.0,
    ).animate(scaleController);


    super.initState();
    changeScreen();
  }

  @override
  void dispose() {
    ac1.dispose();
    ac2.dispose();
    scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          IndexedStack(
            index: index,
            sizing: StackFit.expand,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  gradient: LinearGradient(
                    colors: [
                      Colors.red.shade900.withOpacity(
                          index == 0 ? pageOpacity : 0),
                      Colors.red.shade200.withOpacity(
                          index == 0 ? pageOpacity : 0)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.shade900.withOpacity(
                          index == 1 ? pageOpacity : 0),
                      Colors.blue.shade200.withOpacity(
                          index == 1 ? pageOpacity : 0)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  gradient: LinearGradient(
                    colors: [
                      Colors.green.shade900.withOpacity(
                          index == 2 ? pageOpacity : 0),
                      Colors.green.shade200.withOpacity(
                          index == 2 ? pageOpacity : 0)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                scaleController.forward();
              },
              child: AnimatedBuilder(
                animation: scaleController,
                builder: (context, child) =>
                    Transform.scale(
                      scale: scaleAnimation.value,
                      child: Container(
                        padding: EdgeInsets.all(50),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 10,
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey,
                          highlightColor: Colors.white,
                          child: Text(
                            'LETS',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 50,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

