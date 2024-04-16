import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationServices extends StatefulWidget {
  const LocationServices({super.key});

  @override
  State<LocationServices> createState() => _LocationServicesState();
}

class _LocationServicesState extends State<LocationServices> {
  getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      log("Location Denied");
      LocationPermission ask = await Geolocator.requestPermission();
    } else {
      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      // log("Latitude=${currentPosition.latitude.toString()}");
      // log("Longitude=${currentPosition.longitude.toString()}");

      double long = currentPosition.longitude;
      double lat = currentPosition.latitude;
      return [long, lat];
    }
  }

  @override
  Widget build(BuildContext context) {
    // double lat = 22.5150451;
    // double long = 88.4104882;
    double lat = 22.5150451;
    double long = 88.4104882;

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("LOCATION"),
          ),
          body: Stack(
            children: [
              // Align(
              //   alignment: Alignment.bottomRight,
              //   child: Padding(
              //     padding: EdgeInsets.all(16.0),
              //     child: ElevatedButton(
              //       onPressed: () async {
              //         var location = await getCurrentLocation();
              //         lat = location[0];
              //         long = location[1];
              //         print(lat);
              //       },
              //       child: Icon(
              //         Icons.location_on,
              //         color: Colors.blue,
              //         size: 24.0,
              //       ),
              //     ),
              //   ),
              // ),
              Align(
                alignment: Alignment.center,
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: LatLng(lat, long),
                    initialZoom: 9.2,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            var location = await getCurrentLocation();
                            lat = location[0];
                            long = location[1];
                            print(location);
                          },
                          child: Icon(
                            Icons.location_on,
                            color: Colors.blue,
                            size: 24.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
