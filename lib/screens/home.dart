import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_clone/utils/core.dart';
import 'package:geolocator/geolocator.dart';
import '../requests/google_maps_request.dart';



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


  //Google Map Services
  GoogleMapsServices _googleMapsServices = GoogleMapsServices();


  //Text Editing Pick up Location Controller 
  TextEditingController locationController = TextEditingController();


  //Text Editing DestinationLocation Controller 
  TextEditingController destinationController = TextEditingController();



  //current location from map
  static LatLng _initialPosition;


  //last location from map
  LatLng _lastPostion = _initialPosition;

  //here we'll define set of list object
  final Set<Marker> _markers = {};

  //Here 'Polyline' does draw from pick up to Destination Line draw
  final Set<Polyline> _polyLines = {};



  //Here we'll override our initial state
  @override 
  void initState(){

    super.initState();

    _getUserLocation();

  }




  @override
  Widget build(BuildContext context) {

    return _initialPosition == null? Container(


      alignment: Alignment.center,

      child: CircularProgressIndicator(),


      ) : Stack(

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

              //
              controller: locationController,

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





  //----------Here we'll convert List of Double into Latlng -----

  List<LatLng> convertToLatLng(List points){

    List<LatLng> result = <LatLng>[];

      for(int i = 0; i < points.length; i++){

        if(i % 2 != 0){

          result.add(LatLng(points[i-1], points[i]));

        }

        return result;

      } 


  }



    /**
     * 
     * [212.332, 233.5, 2323.5, 5545.7, 4466.7, 4546.7, 4646.89, 40587.90]
     * 
     * (0---------1--------2-------3-------4--------5-------6----------7)
     * 
     */




  //----------------DECODEPOLY which returns LIST of DOUBLES  Begins -----------------

  List decodePoly(String poly){
    var list=poly.codeUnits;
    var lList=new List();
    int index=0;
    int len= poly.length;
    int c=0;
    // repeating until all attributes are decoded
    do
    {
      var shift=0;
      int result=0;

      // for decoding value of one attribute
      do
      {
        c=list[index]-63;
        result|=(c & 0x1F)<<(shift*5);
        index++;
        shift++;
      }while(c>=32);
      /* if value is negetive then bitwise not the value */
      if(result & 1==1)
      {
        result=~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    }while(index<len);

    /*adding to previous value as done in encoding */
    for(var i=2;i<lList.length;i++)
      lList[i]+=lList[i-2];

    print(lList.toString());

    return lList;
  }

  //------------------------- DECODEPOLY which returns LIST of DOUBLES  Ends  ----------------------




  void _getUserLocation() async{

    //Here we'll get the Current Location
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    

    //Here Placemark List Variable
    List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
   


    //
    setState(() {
      
      //Here it'll get cordinates
      _initialPosition = LatLng(position.latitude, position.longitude);
      
      //Here we'll get the above cordinate & translate to address type
      locationController.text = placemark[0].name;
   
    });
  }
  
  // void sendRequest(String intendedLocation)async{
  //   List<Placemark> placemark = await Geolocator().placemarkFromAddress(intendedLocation);
  //   double latitude = placemark[0].position.latitude;
  //   double longitude = placemark[0].position.longitude;
  //   LatLng destination = LatLng(latitude, longitude);
  //   _addMarker(destination, intendedLocation);
  //   String route = await _googleMapsServices.getRouteCoordinates(_initialPosition, destination);
  //   createRoute(route);

  // }


}










