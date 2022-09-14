import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';
import 'dart:convert';

void main() {
  runApp(const HomePage());
}

Map<String,dynamic> GetData() {
  // TODO hash checking with webserver and pulling diffs
  // TODO actually pull (maybe from test server first? at edible_campus_unc/test_server.py)
  return(jsonDecode(File("edible_campus_data.json").readAsStringSync()));
}

class NavDrawer extends Drawer {
  const NavDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
      ListTile(
          leading: const Icon(Icons.home),
          title: const Text("Home"),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          }),
      ListTile(
          leading: const Icon(Icons.map),
          title: const Text("Map"),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MapPage()));
          }),
      ListTile(
          leading: const Icon(Icons.yard),
          title: const Text("Plants"),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => PlantsPage()));
          }),
      ListTile(
          leading: const Icon(Icons.crib),
          title: const Text("Gardens"),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => GardensPage()));
          }),
      ListTile(
          leading: const Icon(Icons.developer_board),
          title: const Text("Dev Mode"),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => DevPage()));
          }),
    ]));
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Edible Campus (m)app',
        theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            colorSchemeSeed: const Color(0xFF62C6F2)),
        home: Scaffold(
          appBar: AppBar(title: const Text('Edible Campus (m)app Home Page')),
          body: const WebView(
              initialUrl: "https://ncbg.unc.edu/outreach/edible-campus-unc/"),
          drawer: NavDrawer(),
        ));
  }
}

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Map")),
      body: Center(child: const Text("placeholder")),
    );
  }
}

class PlantsPage extends StatelessWidget {
  const PlantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Plants")),
      body: Center(child: const Text("placeholder")),
    );
  }
}

class GardensPage extends StatelessWidget {
  const GardensPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gardens")),
      body: Center(child: const Text("placeholder")),
    );
  }
}

class DevPage extends StatefulWidget {
  const DevPage({super.key});

  @override
  State<DevPage> createState() => DevState();
}

class DevState extends State<DevPage> {
  int _page = 0;
  bool bInit = false;

  static List<Widget> garden_tiles = List<Widget>.empty(growable: true);

  static List<Widget> plant_tiles = List<Widget>.empty(growable: true);

  static List<Widget> _pages = [
      ListView(
        padding: const EdgeInsets.all(8),
        children: garden_tiles,
      ),
      ListView(
        padding: const EdgeInsets.all(8),
        children: plant_tiles,
      ),
      const Center(child: Text("Hey"))
  ];

  void _setPage(int index) {
    setState(() {
      _page = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var data = GetData();
    String title;
    if (garden_tiles.isEmpty) {
      for (int i = 0; i < data["garden_keys"].length; i++) {
        title = data["garden"][data["garden_keys"][i].toString()]
                ["title"]
            .toString();
        garden_tiles.add(
          ListTile(
              title: Text(title),
              trailing: const Icon(Icons.more_vert),
          ));
      }
    }
    if (plant_tiles.isEmpty) {
      for (int i = 0; i < data["plant_keys"].length; i++) {
        title = data["plant"][data["plant_keys"][i].toString()]
                ["common"]
            .toString();
        plant_tiles.add(ListTile(
            title: Text(title),
            trailing: const Icon(Icons.more_vert),
));
      }
    }
    return Scaffold(
      appBar: AppBar(title: Text("Dev Mode")),
      body: _pages[_page],
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
      bottomNavigationBar:
          BottomNavigationBar(items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.crib), label: "Gardens"),
        BottomNavigationBarItem(icon: Icon(Icons.yard), label: "Plants"),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle), label: "Account")
      ], currentIndex: _page, onTap: _setPage),
    );
  }
}
