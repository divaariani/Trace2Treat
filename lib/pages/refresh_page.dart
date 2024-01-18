import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:trace2treat/pages/exchangeform_page.dart';
import 'dart:async';
import '../theme/app_colors.dart';

class RefreshTrashForm extends StatefulWidget {
  const RefreshTrashForm({Key? key}) : super(key: key);

  @override
  State<RefreshTrashForm> createState() => _RefreshTrashFormState();
}

class _RefreshTrashFormState extends State<RefreshTrashForm> {
  double myLatitude = 0.0;
  double myLongitude = 0.0;
  String myLocation = '';

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await geolocator.Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    geolocator.LocationPermission permission = await geolocator.Geolocator.checkPermission();
    if (permission == geolocator.LocationPermission.denied) {
      permission = await geolocator.Geolocator.requestPermission();
      if (permission == geolocator.LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == geolocator.LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cant request');
    }

    final position = await geolocator.Geolocator.getCurrentPosition();
    myLatitude = position.latitude;
    myLongitude = position.longitude;
    await getLocationName();

    return await geolocator.Geolocator.getCurrentPosition();
  }

  Future<String> getLocationName() async {
    double latitude = myLatitude;
    double longitude = myLongitude;

    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);

    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks[0];
      String locationName = placemark.name ?? "";
      String thoroughfare = placemark.thoroughfare ?? "";
      String subLocality = placemark.subLocality ?? "";
      String locality = placemark.locality ?? "";
      String administrativeArea = placemark.administrativeArea ?? "";
      String country = placemark.country ?? "";
      String postalCode = placemark.postalCode ?? "";

      String address = "$locationName $thoroughfare $subLocality $locality $administrativeArea $country $postalCode";

      myLocation = address;
      return address;
    } else {
      myLocation = "Location not found";
      return "Location not found";
    }
  }

  // void _liveLocation() {
  //   geolocator.LocationSettings locationSettings = 
  //     const geolocator.LocationSettings(accuracy: geolocator.LocationAccuracy.high, distanceFilter: 1000);

  //   geolocator.Geolocator.getPositionStream(locationSettings: locationSettings).listen((geolocator.Position position) {
  //     double targetLatitude1 = -6.520107;
  //     double targetLongitude1 = 106.830266;
  //     double area1a10003000 = geolocator.Geolocator.distanceBetween(position.latitude, position.longitude, targetLatitude1, targetLongitude1);

  //     double targetLatitude2 = -6.520100;
  //     double targetLongitude2 = 106.831998;
  //     double finishedwarehouse = geolocator.Geolocator.distanceBetween(position.latitude, position.longitude, targetLatitude2, targetLongitude2);

  //     if (area1a10003000 <= 50 || finishedwarehouse <= 50) {
  //       globalLat = position.latitude.toString();
  //       globalLong = position.longitude.toString();

  //       setState(() {
  //         message = 'Latitude $globalLat, Longitude: $globalLong';
  //       });
  //     } else {
  //       setState(() {
  //         message = 'Outside the allowed area';
  //         globalLat = '';
  //         globalLong = '';
  //         globalLocationName = AppLocalizations(globalLanguage).translate("outsideArea");
  //       });
  //     }
  //   });
  // }

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 1), () {
      _getCurrentLocation().then((value) {
        //_liveLocation();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ExchangeFormPage(),
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.white,
        child: Center(
          child: CircularProgressIndicator(color: AppColors.primary)
        ),
      ),
    );
  }
}