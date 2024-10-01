import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class LocalDataProvider {
  // getData

  setSavedLocation({required String location}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("Location", location);
  }

  Future<String?> getSavedLocation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final location = prefs.getString("Location");

    log(location.toString());
    return location;
  }
}
