import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:navigation_bar_app/apiservices/api.dart';
import 'package:http/http.dart' as http;

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List listOfPoints = [];
  List<LatLng> points = [];
//Funcion para consumir la api
  getCoordinates() async {
    var response = await http.get(getRouterUrl(
        "-76.60257258322525, 2.4431439188601978",
        "-76.60257258322525, 2.4431439188601978"));
    setState(() {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        listOfPoints = data['features'][0]['geometry']['coordinates'];
        points = listOfPoints
            .map((e) => LatLng(e[1].toDouble(), e[0].toDouble()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
            initialZoom: 13,
            initialCenter: LatLng(2.4431439188601978, -76.60257258322525)),
        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            userAgentPackageName: 'dev.fleaflet.flutter_map.example',
          ),
          MarkerLayer(
            markers: [
              //Marcador 1
              Marker(
                point: LatLng(2.4431439188601978, -76.60257258322525),
                width: 80,
                height: 80,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.location_on),
                  color: Colors.cyan,
                  iconSize: 45,
                ),
              ),
              //Marcador 2
              Marker(
                point: LatLng(2.484224979244845, -76.5621684975094),
                width: 80,
                height: 80,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.location_on),
                  color: Colors.lightGreenAccent,
                  iconSize: 45,
                ),
              ),
            ],
          ),
          //Polyline Layer
          PolylineLayer(
            polylines: [
              Polyline(points: points, color: Colors.blue, strokeWidth: 5),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getCoordinates();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
