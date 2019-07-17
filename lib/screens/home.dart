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


          //----------'PICK UP' LOCATION WIDGET START------

           Positioned(

          top: 50.0,
          
          right: 15.0,

          left: 15.0,


          child: Container(


            height: 50.0,

            width: double.infinity,


            decoration: BoxDecoration(


              borderRadius: BorderRadius.circular(3.0),

              color: Colors.white,


              boxShadow: [


                BoxShadow(


                  color: Colors.grey,

                  offset: Offset(1.0, 5.0),

                  blurRadius: 10,

                  spreadRadius: 3,


                )

              ]

            ),

            
            child: TextField(

              
              cursorColor: Colors.black,

              decoration: InputDecoration(


                icon: Container(
                  
                    
                  width: 10.0,

                  height: 10.0,


                  margin: EdgeInsets.only(
                    
                    left: 20, 
                    
                    top: 5
                  
                  ),
                  
                
                  child: Icon(
                    
                    Icons.location_on, 
                    
                    color: Colors.black
                    
                  ),

          
                ),


                hintText: "pick up",

                border: InputBorder.none,


                contentPadding: EdgeInsets.only(
                  
                  left: 15.0, 
                  
                  top: 16.0
                  
                ),


              ),

            ),

          ),

        ),

        //----------END 'PICK UP' LOCATION WIDGET ------



        //---------- 'DESTINATION' LOCATION WIDGET START------


        Positioned(

          top: 105,
          
          right: 15.0,

          left: 15.0,


          child: Container(


            height: 50.0,

            width: double.infinity,


            decoration: BoxDecoration(


              borderRadius: BorderRadius.circular(3.0),

              color: Colors.white,


              boxShadow: [


                BoxShadow(


                  color: Colors.grey,

                  offset: Offset(1.0, 5.0),

                  blurRadius: 10,

                  spreadRadius: 3,

                )

              ]

            ),

            

            child: TextField(
              

              cursorColor: Colors.black,

              decoration: InputDecoration(


                icon: Container(
                  

                  width: 10.0,

                  height: 10.0,


                  margin: EdgeInsets.only(
                    
                    left: 20, 
                    
                    top: 5
                  
                  ),
                  

                  child: Icon(
                    
                    Icons.local_taxi, 
                    
                    color: Colors.black
                    
                  ),


                ),


                hintText: "destination?",

                border: InputBorder.none,

                contentPadding: EdgeInsets.only(
                  
                  left: 15.0, 
                 
                  top: 16.0
                  
                ),

              ),

            ),

          ),

        ),


        //---------- END 'DESTINATION' LOCATION WIDGET ------



        // Positioned(

        //   top: 40,
          
        //   right: 10,

        //   child: FloatingActionButton(

        //     onPressed: _onAddMarkerPressed,

        //     tooltip: 'add marker',

        //     backgroundColor: Colors.black,


        //     child: Icon(
              
        //       Icons.add_location,
              
        //       color: white,

        //     ),

        //   ),

        // )

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










