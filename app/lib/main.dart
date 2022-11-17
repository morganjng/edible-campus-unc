import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'ecdata.dart';

ThemeData theme =
    ThemeData(colorSchemeSeed: const Color(0xFF62C6F2), useMaterial3: true);

Map<String, dynamic>? _serverData;
ECData data = ECData.empty();

void main() async {
  await getData();
  runApp(const MapPage());
}

Future<bool> getData() async {
  // TODO hash checking with webserver and pulling diffs
  // TODO actually pull (maybe from test server first? at edible_campus_unc/test_server.py)
  //_serverData = jsonDecode(File("edible_campus_data.json").readAsStringSync());
  var rl = await http.get(Uri.parse(
      'https://edible-campus-unc-server-gribbins.apps.cloudapps.unc.edu/data/latest'));

  if (rl.statusCode == 200) {
    _serverData = jsonDecode(rl.body);
    var sd = _serverData!;

    data = ECData.fromJson(sd);

    return true;
  } else {
    throw Exception("Failed to get data");
  }
}

class NavDrawer extends Drawer {
  const NavDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
      AppBar(
          title: const Text("UNC Edible Campus"),
          leading: const Icon(Icons.energy_savings_leaf)),
      ListTile(
          leading: const Icon(Icons.home),
          title: const Text("Map"),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MapPage()));
          }),
      ListTile(
          leading: const Icon(Icons.map),
          title: const Text("Website"),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          }),
      ListTile(
          leading: const Icon(Icons.yard),
          title: const Text("Plants"),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => data.plantsPage()));
          }),
      ListTile(
          leading: const Icon(Icons.crib),
          title: const Text("Gardens"),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => data.gardensPage()));
          }),
    ]));
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edible Campus (m)app Home Page')),
      body: const WebView(
          initialUrl: "https://ncbg.unc.edu/outreach/edible-campus-unc/"),
    );
  }
}

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Edible Campus (m)app",
        theme: ThemeData(colorSchemeSeed: const Color(0xFF62C6F2)),
        home: Scaffold(
          appBar: AppBar(title: Text("Map")),
          body: ECMap(),
          drawer: NavDrawer(),
        ));
  }
}

class ECMap extends StatefulWidget {
  @override
  State<ECMap> createState() => ECMapState();
}

class ECMapState extends State<ECMap> {
  static const CameraPosition _davisLibrary = CameraPosition(
      target: LatLng(35.91099987656271, -79.04800082831068), zoom: 16);

  @override
  Widget build(BuildContext context) {
    Set<Marker> markers = {};
    data.gardens.values.forEach((bed) => markers.add(Marker(
        markerId: MarkerId(bed.title),
        position: LatLng(bed.latitude, bed.longitude),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => data.gardenPage(bed.key)));
        })));

    return Scaffold(
        body: GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _davisLibrary,
      markers: markers,
    ));
  }
}
