import 'package:flutter/material.dart';
import 'plant.dart';

class Garden {
  String title = "";
  double latitude = 0.0;
  double longitude = 0.0;
  List<dynamic> plants = [];
  List<dynamic> images = [];

  Garden.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    latitude = json["latitude"];
    longitude = json["longitude"];
    plants = json["plants"];
    images = json["images"];
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "latitude": latitude,
        "longitude": longitude,
        "plants": plants,
        "images": images,
      };

  Garden(this.title, this.latitude, this.longitude, this.plants, this.images);
}

class GardenPage extends StatefulWidget {
  Garden garden;
  Map<String, Garden> gardens;
  Map<String, Plant> plants;
  Widget rightHand = Expanded(flex: 50, child: Icon(Icons.energy_savings_leaf));

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
  List<Widget> gardenTiles = List<Widget>.empty(growable: true);
  Map<String, Garden> gardens;
  Map<String, Plant> plants;
  Widget rightHand = Expanded(flex: 50, child: Icon(Icons.ice_skating));

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
    var ps = List<Widget>.empty(growable: true);

    for (int i = 0; i < widget.garden.plants.length; i++) {
      ps.add(ListTile(
          onTap: () {
            setState(() {
              widget.rightHand = Expanded(
                flex: 50,
                child: PlantPage(
                    plant: widget.plants[widget.garden.plants[i]]!,
                    gardens: widget.gardens),
              );
            });
          },
          leading: Text(widget.plants[widget.garden.plants[i]]!.commonName)));
    }

    return Scaffold(
        body: Column(children: [
      Expanded(
        flex: 50,
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: ps,
        ),
      ),
      widget.rightHand,
    ]));
  }
}

class _GardensPageState extends State<GardensPage> {
  @override
  Widget build(BuildContext context) {
    if (widget.gardenTiles.isEmpty) {
      for (var b in widget.gardens.values) {
        widget.gardenTiles.add(ListTile(
          title: Text(b.title),
          trailing: const Icon(Icons.more_vert),
          onTap: () {
            setState(() {
              widget.rightHand = Expanded(
                  flex: 50,
                  child: GardenPage(
                    garden: b,
                    gardens: widget.gardens,
                    plants: widget.plants,
                  ));
            });
          },
        ));
      }
    }
    return Scaffold(
        body: Row(
      children: [
        Expanded(
            flex: 50,
            child: ListView(
                padding: EdgeInsets.zero, children: widget.gardenTiles)),
        widget.rightHand,
      ],
    ));
  }
}
