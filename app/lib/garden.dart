import 'package:flutter/material.dart';
import 'plant.dart';

class Garden {
  String title;
  double latitude;
  double longitude;
  List<dynamic> plants;
  List<dynamic> images;

  Garden(this.title, this.latitude, this.longitude, this.plants, this.images);
}

class GardenPage extends StatefulWidget {
  Garden garden;
  Map<String, Garden> gardens;
  Map<String, Plant> plants;
  bool isApp;

  GardenPage({
    super.key,
    required this.garden,
    required this.gardens,
    required this.plants,
    required this.isApp,
  });

  @override
  State<GardenPage> createState() => _GardenPageState();
}

class GardensPage extends StatefulWidget {
  static List<Widget> gardenTiles = List<Widget>.empty(growable: true);
  Map<String, Garden> gardens;
  Map<String, Plant> plants;
  bool isApp;

  GardensPage(
      {super.key,
      required this.gardens,
      required this.plants,
      required this.isApp});

  @override
  State<GardensPage> createState() => _GardensPageState();
}

class _GardenPageState extends State<GardenPage> {
  @override
  Widget build(BuildContext context) {
    var ps = List<Widget>.empty(growable: true);
    ps.add(ListTile(
        leading:
            const Text("Plants", style: TextStyle(fontWeight: FontWeight.bold)),
        trailing: Text(widget.plants[widget.garden.plants[0]]!.commonName),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PlantPage(
                      plant: widget.plants[widget.garden.plants[0]]!,
                      gardens: widget.gardens,
                      isApp: widget.isApp)));
        }));

    for (int i = 1; i < widget.garden.plants.length; i++) {
      ps.add(ListTile(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PlantPage(
                      plant: widget.plants[widget.garden.plants[i]]!,
                      gardens: widget.gardens,
                      isApp: widget.isApp,
                    )));
          },
          trailing: Text(widget.plants[widget.garden.plants[i]]!.commonName)));
    }

    return Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: ps,
        ),
        appBar: widget.isApp ? AppBar(title: Text(widget.garden.title)) : null);
  }
}

class _GardensPageState extends State<GardensPage> {
  bool bInit = false;

  @override
  Widget build(BuildContext context) {
    if (GardensPage.gardenTiles.isEmpty) {
      for (var b in widget.gardens.values) {
        GardensPage.gardenTiles.add(ListTile(
            title: Text(b.title),
            trailing: const Icon(Icons.more_vert),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => GardenPage(
                        garden: b,
                        gardens: widget.gardens,
                        plants: widget.plants,
                        isApp: widget.isApp,
                      )));
            }));
      }
    }

    return Scaffold(
      appBar: widget.isApp ? AppBar(title: const Text("Gardens")) : null,
      body:
          ListView(padding: EdgeInsets.zero, children: GardensPage.gardenTiles),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
      bottomNavigationBar: widget.isApp
          ? BottomNavigationBar(items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.crib), label: "Gardens"),
              BottomNavigationBarItem(icon: Icon(Icons.yard), label: "Plants"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle), label: "Account")
            ], currentIndex: 0, onTap: null)
          : null,
    );
  }
}
