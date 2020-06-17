import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:letsapp/forGo/place.dart';
import 'package:maps_curved_line/maps_curved_line.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as tool;
import 'dart:io';

class LetsGo extends StatefulWidget {
  static String route = '/letsgo';

  @override
  _LetsGoState createState() => _LetsGoState();
}

class _LetsGoState extends State<LetsGo> with SingleTickerProviderStateMixin {

  String from = '';
  String to = '';
  Position me;
  LatLng home = LatLng(1.306992, 103.924665);
  LatLng currentPlace;


  List<Marker> allPlaces = [];

  GoogleMapController _controller;

  double zoomVal = 16;

  PageController pageController;


  //zoom in out function

  Widget zoomInFunction(){
    return Positioned(
      left: 15,
      top: 140,
      child: IconButton(
        icon: Icon(FontAwesomeIcons.searchPlus, color: Color(0xFF042f63), size: 30,),
        onPressed: (){
          zoomVal = zoomVal + 0.5;
          plus(zoomVal);
        },
      ),
    );
  }

  Widget zoomOutFunction(){
    return Positioned(
      top: 140,
      right:14,
      child: IconButton(
        icon: Icon(FontAwesomeIcons.searchMinus, color: Color(0xFF042f63),size: 30,),
        onPressed: (){
          zoomVal = zoomVal - 0.5;
          minus(zoomVal);
        },
      ),
    );
  }

  void minus(zoomVal){
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target:currentPlace == null? home: currentPlace, zoom: zoomVal)));;
  }

  void plus(zoomVal){
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target:currentPlace == null? home: currentPlace, zoom: zoomVal)));
  }


  //Page view scrolling

  Widget horizontalPageView(){
    return Positioned(
      bottom: 20,
      child: Container(
        height: 200,
        width: MediaQuery.of(context).size.width,
        child: PageView.builder(
          controller: pageController,
          //change when add new places (bad design!!)
          itemCount: 5,
          itemBuilder: (BuildContext context, int index){
            return aPlace(index);
          },
        ),
      ),
    );
  }

  AnimatedBuilder aPlace(int index){
    return AnimatedBuilder(
      animation: pageController ,
      builder: (BuildContext context, Widget widget){
        double value = 1;
        if(pageController.position.haveDimensions){
          value = pageController.page - 1;
          value = (1-(value.abs() * 3)+ 0.06).clamp(0.0,1.0);
        }
        return Center(
          child:SizedBox(
            height:  125,
            width:  350,
            child: widget ,
          ),
        );
      },
      child: InkWell(
        onTap: (){
          moveMap();
        },
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal:10, vertical:20,),
                height: 125,
                width: 275,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      offset: Offset(0,4),
                      blurRadius:10.0,
                    ),
                  ],
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(places[index].thumbnail),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            places[index].placeName,
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            places[index].address,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            width: 170,
                            child: Text(
                              places[index].description,
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }


  void moveMap(){
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: places[pageController.page.toInt()].coord, zoom: 16, tilt: 45, bearing: 45, )));
    currentPlace = places[pageController.page.toInt()].coord;
  }

  int noPressedMarkers = 0;
  bool goPressed = false;
  Set<Polyline> polyline = Set();
  LatLng pointFrom;
  LatLng pointTo;
  TextEditingController cFrom = TextEditingController();
  TextEditingController cTo = TextEditingController();
  double distanceBetweenPoints;
  bool added2 = false;

  void putMarker(LatLng pressed){
    if(!goPressed) {
      if (noPressedMarkers == 0) {
        noPressedMarkers++;
        pointFrom = pressed;
        setState(() {
          allPlaces.add(Marker(
            markerId: MarkerId('from'),
            infoWindow: InfoWindow(
                title: '${pressed.latitude.toStringAsFixed(4)}N, ${pressed
                    .longitude.toStringAsFixed(4)}E'),
            draggable: false,
            position: pressed,
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueCyan),
          ));
          cFrom.text =
          '${pressed.latitude.toStringAsFixed(4)}N, ${pressed.longitude
              .toStringAsFixed(4)}E';
        });
      } else if (noPressedMarkers == 1) {
        noPressedMarkers++;
        pointTo = pressed;
        setState(() {
          allPlaces.add(Marker(
            markerId: MarkerId('to'),
            infoWindow: InfoWindow(
                title: '${pressed.latitude.toStringAsFixed(4)}N, ${pressed
                    .longitude.toStringAsFixed(4)}E'),
            draggable: false,
            position: pressed,
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueCyan),
          ));
          cTo.text =
          '${pressed.latitude.toStringAsFixed(4)}N, ${pressed.longitude
              .toStringAsFixed(4)}E';
        });
        added2 = true;
      } else {

      }
    }
  }

  AnimationController distanceBarController;
  Animation<double> animation;
  double opacity = 0;

  Widget distanceBar(){
    return Positioned(
      top: 125,
      left: 70,
      right: 70,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Container(
          padding: EdgeInsets.all(5),
          height: 50,
          width: 250,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(opacity),
            borderRadius: BorderRadius.circular(20),
            boxShadow:[
              BoxShadow(
                color: Colors.black.withOpacity(opacity),
                offset: Offset(1,1),
                blurRadius: 2,
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              FadeTransition(
                opacity: animation == null? 0 : animation,
                child: Text(
                    'Total Distance: ${distanceBetweenPoints < 1000 ? distanceBetweenPoints.toStringAsFixed(3) + 'm' : (distanceBetweenPoints/1000).toStringAsFixed(1) + 'km'}',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                'Walking time: ${((distanceBetweenPoints/1.4)/60).toStringAsFixed(2)}mins',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  //init
  @override
  void initState() {
    super.initState();
    places.forEach((element) {
      allPlaces.add(Marker(
        markerId: MarkerId(element.placeName),
        draggable: false,
        infoWindow: InfoWindow(title: element.placeName, snippet: element.description),
        position: element.coord,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
      ));
    });
    pageController = PageController(initialPage: 1, viewportFraction: 0.8);
    distanceBarController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(distanceBarController);
  }


  //build
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        if(!currentFocus.hasPrimaryFocus){
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.lightBlueAccent,
              Color(0xFFe6fcff),
            ]),
          ),
          child: SafeArea(
            child: Stack(
              children: [

                //main Text fields & map

                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    //TextField

                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        child: TextField(
                          controller: cFrom,
                          readOnly: true,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 12, left: 3),
                            prefixIcon: Icon(
                              Icons.home,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Mandarin Gardens #11-33 448908',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                          ),
                        ),
                      ),
                    ),

                    //TextField & Go Button

                    Expanded(
                      flex: 1,
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 320,
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 2),
                            child: TextField(
                              controller: cTo,
                              readOnly: true,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 12, left: 4),
                                prefixIcon: Icon(Icons.search),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Go To (hold down somewehere)',
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              height: 50,
                              width: 70,
                              decoration: BoxDecoration(
                                color: Color(0xFF042f63),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(1, 1),
                                      color: Colors.black,
                                      blurRadius: 4)
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: InkWell(
                                onTap: () {
                                  if(!goPressed && added2 ){
                                    setState(() {
                                      goPressed = true;
                                      polyline.add(
                                        Polyline(
                                          polylineId: PolylineId('line'),
                                          visible: true,
                                          width: 2,
                                          patterns: [PatternItem.dash(30), PatternItem.gap(10)],
                                          points: MapsCurvedLines.getPointsOnCurve(pointFrom,pointTo),
                                          color: Colors.blue,
                                        ),
                                      );
                                      if (pointFrom != null && pointTo != null){
                                        distanceBetweenPoints = tool.SphericalUtil.computeDistanceBetween(
                                          tool.LatLng(pointFrom.latitude,pointFrom.longitude),
                                          tool.LatLng(pointTo.latitude, pointTo.longitude),
                                        );
                                      }
                                      distanceBarController.forward(from: 0);
                                      distanceBarController.addListener(() {
                                        setState(() {
                                          opacity = distanceBarController.value;
                                        });
                                      });
                                    });
                                    print('go');
                                  } else if(goPressed) {
                                    setState(() {
                                      goPressed = false;
                                      distanceBarController.reverse(from: 1);
                                      distanceBarController.addListener(() {
                                        setState(() {
                                          opacity = distanceBarController.value;
                                        });
                                      });
                                      polyline.clear();
                                      allPlaces.removeWhere((element) => element.markerId.value == 'to' || element.markerId.value == 'from' );
                                      allPlaces.removeWhere((element) => element.markerId.value == 'to' || element.markerId.value == 'from' );
                                      noPressedMarkers = 0;
                                      cFrom.clear();
                                      cTo.clear();
                                      distanceBetweenPoints = 0;
                                      added2 = false;
                                    });
                                    print('done');
                                  }
                                },
                                child: Center(
                                    child: Text(
                                  !goPressed ? 'GO' : 'Done',
                                  style: TextStyle(color: Colors.white),
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //Map

                    Expanded(
                      flex: 11,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        height: 800,
                        width: MediaQuery.of(context).size.width,
                        child: GestureDetector(
                          onTap: (){
                            FocusScopeNode focus = FocusScope.of(context);
                            if(!focus.hasPrimaryFocus){
                              focus.unfocus();
                            }
                          },
                          child: GoogleMap(
                            polylines: noPressedMarkers == 0 ? null : polyline,
                            onLongPress: (position){
                              putMarker(position);
                            },
                            onCameraMove: (position){
                              currentPlace = position.target;
                            },
                            markers: Set.from(allPlaces),
                            onMapCreated: mapCreated,
                            myLocationButtonEnabled: false,
                            initialCameraPosition: CameraPosition(
                              target: home,
                              zoom: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                zoomInFunction(),
                zoomOutFunction(),
                horizontalPageView(),
                goPressed ? distanceBar() : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }
}

