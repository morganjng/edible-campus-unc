import 'package:flutter/material.dart';
import 'plant.dart';

class Garden {
  String title = "";
  double latitude = 0.0;
  double longitude = 0.0;
  List<dynamic> plants = [];
  List<dynamic> images = [];
  String key = "";

  Garden.fromJson(Map<String, dynamic> json, String key) {
    title = json["title"];
    latitude = json["latitude"];
    longitude = json["longitude"];
    plants = json["plants"];
    images = json["images"];
    key = key;
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "latitude": latitude,
        "longitude": longitude,
        "plants": plants,
        "images": images
      };

  Garden(this.title, this.latitude, this.longitude, this.plants, this.images,
      this.key);
}

class GardenPage extends StatefulWidget {
  Garden garden;
  Map<String, Garden> gardens;
  Map<String, Plant> plants;

  GardenPage({
    super.key,
    required this.garden,
    required this.gardens,
    required this.plants,
  });

  @override
  State<GardenPage> createState() => _GardenPageState();
}

class GardensPage extends StatefulWidget {
  Map<String, Garden> gardens;
  Map<String, Plant> plants;

  GardensPage({
    super.key,
    required this.gardens,
    required this.plants,
  });

  @override
  State<GardensPage> createState() => _GardensPageState();
}

class _GardenPageState extends State<GardenPage> {
  @override
  Widget build(BuildContext context) {
    // print("he");
    // print(widget.garden.plants.toList().toString());
    List<Widget> ps = List<Widget>.empty(growable: true);
    ps.add(const Text("Common Name",
        textAlign: TextAlign.left,
        style: TextStyle(fontWeight: FontWeight.bold)));
    ps.add(ListTile(leading: Text(widget.garden.title)));

    ps.add(const Text("Latitude",
        textAlign: TextAlign.left,
        style: TextStyle(fontWeight: FontWeight.bold)));
    ps.add(ListTile(leading: Text(widget.garden.latitude.toString())));
    ps.add(const Text("Longitude",
        textAlign: TextAlign.left,
        style: TextStyle(fontWeight: FontWeight.bold)));
    ps.add(ListTile(leading: Text(widget.garden.longitude.toString())));
    ps.add(const Text("Plants",
        textAlign: TextAlign.left,
        style: TextStyle(fontWeight: FontWeight.bold)));

    for (int i = 0; i < widget.garden.plants.length; i++) {
      ps.add(ListTile(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PlantPage(
                      plant: widget.plants[widget.garden.plants[i]]!,
                      gardens: widget.gardens,
                    )));
          },
          leading: Text(widget.plants[widget.garden.plants[i]]!.commonName)));
    }
    List<Widget> images = List<Widget>.empty(growable: true);
    for (dynamic path in widget.garden.images) {
      images.add(Image.network(path.toString()));
    }
    return Scaffold(
        appBar: AppBar(title: Text(widget.garden.title)),
        body: Column(children: [
          Expanded(
              flex: 40,
              child:
                  ListView(scrollDirection: Axis.horizontal, children: images)),
          Expanded(
            flex: 60,
            child: ListView(children: ps),
          )
        ]));

    return Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: ps,
        ),
        appBar: AppBar(title: Text(widget.garden.title)));
  }
}

class _GardensPageState extends State<GardensPage> {
  bool bInit = false;

  @override
  Widget build(BuildContext context) {
    List<Widget> gardenTiles = List<Widget>.empty(growable: true);
    for (var b in widget.gardens.values) {
      gardenTiles.add(ListTile(
          title: Text(b.title),
          trailing: const Icon(Icons.more_vert),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => GardenPage(
                      garden: b,
                      gardens: widget.gardens,
                      plants: widget.plants,
                    )));
          }));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Gardens")),
      body: ListView(padding: EdgeInsets.zero, children: gardenTiles),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
    );
  }
}
