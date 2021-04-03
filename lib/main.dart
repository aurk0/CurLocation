import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: LctnBtn());
  }
}

class LctnBtn extends StatefulWidget {
  @override
  _LctnBtnState createState() => _LctnBtnState();
}

class _LctnBtnState extends State<LctnBtn> {
  var locMessage = "";
  String latitude = "";
  String longtitude = "";

  currentLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lat = position.latitude;
    var long = position.longitude;

    latitude = "$lat";
    longtitude = "$long";

    setState(() {
      locMessage = "Latitude: $lat & Longtitude: $long";
    });
  }

  void openInGoogleMap() async {
    String map =
        "https://www.google.com/maps/search/?api=1&quert=$latitude,$longtitude";

    if (await canLaunch(map)) {
      await launch(map);
    } else
      throw ("Can't open maps");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_pin,
              size: 70,
              color: Colors.blue,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.cyan),
              child: Center(
                  child: TextButton(
                      onPressed: () {
                        currentLocation();
                      },
                      child: Text(
                        'CURRENT LOCATION',
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ))),
            ),
            SizedBox(
              height: 15,
            ),
            Text(locMessage),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 40,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.cyan),
              child: Center(
                  child: TextButton(
                      onPressed: () {
                        openInGoogleMap();
                      },
                      child: Text(
                        'Open Map',
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ))),
            )
          ],
        ),
      ),
    );
  }
}
