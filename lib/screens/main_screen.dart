import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uber_clone/widgets/drawer_button.dart';
import 'package:geolocator/geolocator.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  static String id = 'mainScreen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late GoogleMapController newGoogleMapController;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  // @override
  // void initState() {
  //   super.initState();
  //   locatePosition();
  // }

  late double laitutde;
  late double longitude;

  void locatePosition () async{

    try{
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      laitutde = position.latitude;
      longitude = position.longitude;

      LatLng latLaPosition = LatLng(position.latitude, position.longitude);
      
      CameraPosition cameraPosition = new CameraPosition(target: latLaPosition, zoom: 14);
      newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      
      print(longitude);
      print(laitutde);
    }
    catch(e){
      print(e);
      print('kuch problem h');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.grey,
      drawer: Container(
        width: MediaQuery.of(context).size.width * 0.56,
        child: Drawer(
          child: Column(
            children: <Widget>[
              DrawerHeader(
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: AssetImage(
                        'images/user_icon.png',
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Profile Name',
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        GestureDetector(
                          onTap: () {
                            print('helo');
                          },
                          child: Text(
                            'Profile Name',
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              DrawerButton(
                dIcon: Icon(Icons.history_rounded),
                title: 'History',
                onPressed: () {
                  print('hello');
                },
              ),
              DrawerButton(
                title: 'Visit Profile',
                onPressed: () {},
                dIcon: Icon(
                  Icons.person,
                ),
              ),
              DrawerButton(
                title: 'About',
                onPressed: () {},
                dIcon: Icon(
                  Icons.info_rounded,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            initialCameraPosition: _kGooglePlex,
            mapType: MapType.normal,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;
              locatePosition();
            },
          ),
          Positioned(
            top: 45,
            left: 25,
            child: GestureDetector(
              onTap: (){
                print('hello');
                scaffoldKey.currentState!.openDrawer();
              },
              child: Container(
                height: 66,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    blurRadius: 16,
                    spreadRadius: 0.5
                  )],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.menu,
                    size: 33,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    blurRadius: 20,
                    spreadRadius: 0.5,
                    offset: Offset(0.6, 0.6),
                  )
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 26, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Hello!',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      'Where to?',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      // controller: passwordTextEditingController,
                      cursorColor: Colors.black54,
                      decoration: InputDecoration(
                        hintText: 'Kidhar jaane ka hai?',
                        hintStyle: GoogleFonts.lato(
                          textStyle: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black54),
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black54,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black54,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black54,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                      ),
                    ),
                    SizedBox(
                      height: 17,
                    ),
                    Container(
                      child: ListTile(
                        leading: Icon(
                          Icons.home,
                          color: Colors.black54,
                          size: 29,
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Add Home',
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    fontSize: 18,
                                    // fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                            ),
                            Text(
                              'Click to add home address',
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    fontSize: 13,
                                    // fontWeight: FontWeight.w400,
                                    color: Colors.black54),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 0.4,
                      height: 0,
                    ),
                    Container(
                      child: ListTile(
                        leading: Icon(
                          Icons.work,
                          color: Colors.black54,
                          size: 29,
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Add Office',
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    fontSize: 18,
                                    // fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                            ),
                            Text(
                              'Click to add office address',
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    fontSize: 13,
                                    // fontWeight: FontWeight.w400,
                                    color: Colors.black54),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
