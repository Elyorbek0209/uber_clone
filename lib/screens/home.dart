import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class MyHomePage extends StatefulWidget {


  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();

}




class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      //#2 Here we'll call Map() Class from below
      body: Map(),

    );
  }
}




//#1 Here we'll create staful widget 
class Map extends StatefulWidget {

  @override
  _MapState createState() => _MapState();

}


class _MapState extends State<Map> {


  //#3 Here we'll define 'googlemapController'
  GoogleMapController mapController;

  //current location from map
  static const _initialPosition = LatLng(41.05, 73.53);


  //last location from map
  LatLng _lastPostion = _initialPosition;

  //here we'll define set of list object
  final Set<Marker> _markers = {};



  @override
  Widget build(BuildContext context) {

    return Stack(

      children: <Widget>[

        //--------GOOGLE MAP OBJECT PROPERTIES ---------

        GoogleMap(

          initialCameraPosition: CameraPosition(
            
            target: _initialPosition,
          
            zoom: 10.0
          
          ),

          //
          onMapCreated: onCreated,

          //Enabling current Location
          myLocationEnabled: true,

          //Declaring Map Type
          mapType: MapType.normal,

          //
          markers: _markers,

          //
          onCameraMove: _onCameraMove,





        )

      ],
      
    );
  }




  void onCreated(GoogleMapController controller){

    setState(() {
      
      mapController = controller;


    });

  }



  void _onCameraMove(CameraPosition position){



  }

}










