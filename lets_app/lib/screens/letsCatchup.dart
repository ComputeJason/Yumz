import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:letsapp/forCatchup/friend.dart';
import 'package:url_launcher/url_launcher.dart';

class LetsCatchup extends StatefulWidget {
  static String route = '/letscatchgup';

  @override
  _LetsCatchupState createState() => _LetsCatchupState();
}

class _LetsCatchupState extends State<LetsCatchup> {

  int currentPerson = 0;

  Future<void> _launchApp(String url) async {
    if (await canLaunch(url)) {
      final bool nativeAppLaunchSucceeded = await launch(
        url,
        forceSafariVC: false,
        universalLinksOnly: true,
      );
      if (!nativeAppLaunchSucceeded) {
        await launch(
          url,
          forceSafariVC: true,
        );
      }
    } else {
      throw 'could not launch $url';
    }
  }

  Future<void> _call(String num) async {
    if (await canLaunch(num)) {
      await launch(num);
    } else {
      throw 'cannot call num $num';
    }
  }

  void launchApp(String url){
    print('tele $url');
  }

  void call(String num) {
    print('called $num');
  }



  Widget swipeBox(int index) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return ExtraInfo(num: index);
            });
      },
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(7, 2),
              spreadRadius: 1,
              blurRadius: 3,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              child: Image(
                image: AssetImage(friends[index].mainImageURL),
                height: 575,
                width: 375,
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              bottom: 10,
              left: 15,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      friends[index].name,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black,
                            blurRadius: 5,
                            offset: Offset(5, 5),
                          )
                        ],
                      ),
                    ),
                    Text(
                      friends[index].description,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        shadows: [
                          Shadow(
                            color: Colors.black,
                            blurRadius: 5,
                            offset: Offset(3, 3),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  SwiperController swiper = SwiperController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            color: Color(0xFF306e52),
            gradient: LinearGradient(
              colors: [
                Colors.green.shade400,
                Color(0xFF306e52),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.bottomRight,
            )),
        child: Column(
          children: <Widget>[
            Swiper(
              itemBuilder: (BuildContext context, int index) {
                currentPerson = index == 0 ? 2 : index - 1;
                return swipeBox(index);
              },
              itemCount: 3,
              itemWidth: 375.0,
              itemHeight: 575.0,
              layout: SwiperLayout.TINDER,
              controller: swiper,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RawMaterialButton(
                    onPressed: () {
                      launchApp(friends[currentPerson].tele);
                    },
                    fillColor: Colors.lightBlueAccent,
                    shape: CircleBorder(),
                    child: Icon(
                      FontAwesomeIcons.telegram,
                      color: Colors.white,
                      size: 64,
                    ),
                  ),
                  SizedBox(
                    width: 13,
                  ),
                  RawMaterialButton(
                    onPressed: () {
                      call(friends[currentPerson].phoneNum);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(60)),
                        side: BorderSide(color: Colors.white, width: 0.8)),
                    fillColor: Colors.greenAccent.shade700,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Call Now',
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    constraints: BoxConstraints(minHeight: 50, minWidth: 160),
                  ),
                  SizedBox(
                    width: 13,
                  ),
                  RawMaterialButton(
                    onPressed: () {
                      setState(() {
                        swiper.next();
                      });
                    },
                    fillColor: Colors.redAccent,
                    shape: CircleBorder(),
                    child: Icon(
                      FontAwesomeIcons.xbox,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExtraInfo extends StatelessWidget {
  ExtraInfo({@required this.num});

  final int num;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFF2f5633),
          ),
        ),
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
            gradient: LinearGradient(
              colors: [Color(0xFF67b56f), Color(0xFFbaf5b3)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    friends[num].ig,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.underline,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    child: Image(
                      image: AssetImage(friends[num].secondImageURL),
                      fit: BoxFit.fill,
                      width: 320,
                      height: 250,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 2, right: 10, left: 10, bottom: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: Text(
                      friends[num].secondDescription == null
                          ? ''
                          : friends[num].secondDescription,
                      style: TextStyle(
//                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
