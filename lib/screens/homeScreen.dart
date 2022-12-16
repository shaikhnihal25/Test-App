// ignore_for_file: prefer_const_constructors, missing_return

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geojson/geojson.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test_app/services/api_manager.dart';
import 'package:test_app/services/data_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key key,
  }) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<LoginData>> _future;
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
    return FutureBuilder<List<LoginData>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(itemBuilder: (context, index) {});
          }

          return Scaffold(
            body: GoogleMap(
                initialCameraPosition:
                    CameraPosition(target: LatLng(0.0000, 0.0000))),
          );
        });
  }
}
