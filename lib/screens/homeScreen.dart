// ignore_for_file: prefer_const_constructors, missing_return

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geojson/geojson.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test_app/services/api_manager.dart';
import 'package:test_app/services/data_model.dart';
import 'package:test_app/services/geoData_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key key,
  }) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GoogleMapController mapController;
  Future<List<GeoData>> _future;
  Map<String, Marker> _markers = {};
  //-----------------//
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  LatLng currentLocation = LatLng(18.5554521, 73.9410411);
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

//----------------//
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Api_Manager().getData();
  }

  //------------------------//

  //----------------------------//

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<GeoData>>(
        future: _future,
        builder: (context, snapshot) {
          var coordinates = snapshot.data;

          if (snapshot.hasData) {
            return Scaffold(
              body: GoogleMap(
                  onMapCreated: (controller) {
                    mapController = controller;
                    addMarker("test", currentLocation);
                  },
                  markers: _markers.values.toSet(),
                  trafficEnabled: true,
                  initialCameraPosition:
                      CameraPosition(target: currentLocation, zoom: 14)),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text("Loading..."),
              ),
            );
          }
        });
  }

  addMarker(String markerID, LatLng location) {
    var marker = Marker(markerId: MarkerId(markerID), position: location);

    _markers[markerID] = marker;
    setState(() {});
  }
}
