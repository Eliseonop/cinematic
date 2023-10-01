import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class VelocimetroWidget extends StatefulWidget {
  @override
  _VelocimetroWidgetState createState() => _VelocimetroWidgetState();
}

class _VelocimetroWidgetState extends State<VelocimetroWidget> {
  double currentSpeed = 0;
  LocationPermission hasLocationPermission = LocationPermission.denied;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    checkLocationPermission();
    // startLocationTracking();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> checkLocationPermission() async {
    var status = await Geolocator.checkPermission();
    print(status);
    setState(() {
      hasLocationPermission = status;
    });
    if (hasLocationPermission == LocationPermission.denied) {
      await requestLocationPermission();
    } else if (hasLocationPermission == LocationPermission.always ||
        hasLocationPermission == LocationPermission.whileInUse) {
      startLocationTracking();
    }
  }

  // mostrar cada segundo el valor de  LocationPermission

  Future<void> requestLocationPermission() async {
    var status = await Geolocator.requestPermission();
    print(status);
    setState(() {
      hasLocationPermission = status;
    });

    if (hasLocationPermission == LocationPermission.always ||
        hasLocationPermission == LocationPermission.whileInUse) {
      startLocationTracking();
    }
  }

  void startLocationTracking() {
    Geolocator.getPositionStream(
        locationSettings: AndroidSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 0,
    )).listen((Position position) {
      setState(() {
        print(position.speed);
        currentSpeed = position.speed;
      });

      if (currentSpeed >= 1) {
        showSpeedLimitNotification();
      }
    });
  }

  Future<void> showSpeedLimitNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'speed_limit_channel',
      'Speed Limit Notifications',
      importance: Importance.high,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    var csToKmh = currentSpeed * 3.6;
    await flutterLocalNotificationsPlugin.show(
      0,
      '¡Velocidad excedida!',
      'Velocidad actual ${csToKmh.toStringAsFixed(2)}  km/h en zona de ${1 * 3.6} km/h',
      platformChannelSpecifics,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (hasLocationPermission == LocationPermission.denied ||
            hasLocationPermission == LocationPermission.deniedForever)
          Column(
            children: [
              Container(
                  child: Text(
                'No se ha otorgado permiso de ubicación',
                style: TextStyle(fontSize: 20),
              )),
              ElevatedButton(
                child: Text(
                  'Pedir permiso de ubicación',
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
                onPressed: () async {
                  await requestLocationPermission();
                },
              ),
            ],
          ),
        if (hasLocationPermission == LocationPermission.unableToDetermine ||
            hasLocationPermission == LocationPermission.always ||
            hasLocationPermission == LocationPermission.whileInUse)
          Column(
            children: [
              Text(
                'Velocidad Actual:',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                '${currentSpeed.toStringAsFixed(2)} m/s',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                '${(currentSpeed * 3.6).toStringAsFixed(2)} km/h',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
      ],
    );
  }
}
