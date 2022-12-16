// ignore_for_file: missing_return, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geojson/geojson.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/screens/homeScreen.dart';
import 'package:test_app/services/data_model.dart';

class Api_Manager {
  Future<List<LoginData>> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("session_token");
    var client = http.Client();
    var url = Uri.parse(
        "https://api.terrablender.com/terraprocess/api/v2/sys/data/lattest_excavation?geo=true");
    var response =
        await client.get(url, headers: {"Authentication": "Bearer $token"});

    if (response.statusCode == 200) {
      List JsonResponse = json.decode(response.body);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("geojson", response.body);
      print(response.body);
      return JsonResponse.map((e) => LoginData.fromJson(e)).toList();
    }
    print(response.body);
  }

  Future<http.Response> loginPost(
      String username, String passcode, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      var data = {"username": username, "passcode": passcode};
      var url = Uri.parse(
        "https://api.terrablender.com/terraprocess/api/v2/open/login",
      );

      var response = await http.post(
        url,
        body: jsonEncode(data),
        headers: {"Content-Type": "text/plain"},
      );
      Map abc = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final d = await prefs.setString("session_token", abc["session_token"]);
        print(d);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
      print(response.statusCode);

      // final sample = await prefs.getString("session_token");
      // print(sample);
    } catch (e) {
      print(e.toString());
    }
  }
}
