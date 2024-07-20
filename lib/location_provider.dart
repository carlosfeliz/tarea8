import 'package:flutter/foundation.dart';

class LocationProvider with ChangeNotifier {
  late String name;
  late String surname;
  late double latitude;
  late double longitude;

  void setLocation({
    required String name,
    required String surname,
    required double latitude,
    required double longitude,
  }) {
    this.name = name;
    this.surname = surname;
    this.latitude = latitude;
    this.longitude = longitude;
    notifyListeners();
  }
}
