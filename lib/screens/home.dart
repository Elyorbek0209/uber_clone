import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_clone/utils/core.dart';


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
          compassEnabled: true,

          //
          markers: _markers,

          //
          onCameraMove: _onCameraMove,

        ),



        Positioned(

          top: 40,
          
          right: 10,

          child: FloatingActionButton(

            onPressed: _onAddMarkerPressed,

            tooltip: 'add marker',

            backgroundColor: Colors.black,


            child: Icon(
              
              Icons.add_location,
              
              color: white,

            ),

          ),

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

    setState(() {
      
      _lastPostion = position.target;

    });


  }


  //------Here we'll add our Red Location Pin-----
  void _onAddMarkerPressed(){

    setState(() {
      
      _markers.add(
        
        Marker(markerId:  
        

          MarkerId(_lastPostion.toString()),

          position: 
          
            _lastPostion, 
            
            infoWindow: InfoWindow(

              title: "remember here",

              snippet: "good place"

            ),

              
          icon: BitmapDescriptor.defaultMarker,
        
        ),

      );

    });
    
  }
  //------------------PIN ENDS------------------------------
}










