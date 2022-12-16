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
  //-----------------//
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  LatLng _center = LatLng(18.5554521, 73.9410411);
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

    final marker = Marker(
      markerId:
          MarkerId("Choudhari Wasti, Kharadi, Pune, Maharashtra 411014,India"),
      position: LatLng(9.669111, 80.014007),
      // icon: BitmapDescriptor.,
      infoWindow: InfoWindow(
        title: 'title',
        snippet: 'address',
      ),
    );

    setState(() {
      markers[MarkerId(
          "Choudhari Wasti, Kharadi, Pune, Maharashtra 411014,India")] = marker;
    });
  }

//----------------//
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = Api_Manager().getData();
  }

  //------------------------//

  //----------------------------//

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<GeoData>>(
        future: _future,
        builder: (context, snapshot) {
          var coordinates = snapshot.data;
          print(coordinates);
          if (snapshot.hasData) {
            return Scaffold(
              body: GoogleMap(
                  onMapCreated: _onMapCreated,
                  trafficEnabled: true,
                  initialCameraPosition:
                      CameraPosition(target: _center, zoom: 100)),
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
}
