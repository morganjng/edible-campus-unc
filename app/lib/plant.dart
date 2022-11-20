import 'package:flutter/material.dart';
import 'garden.dart';

class Plant {
  String commonName = "";
  String scientificName = "";
  List<dynamic> images = [];
  String recipes = "";
  String description = "";
  String key = "";

  Plant.fromJson(Map<String, dynamic> json, String key) {
    commonName = json["common"];
    scientificName = json["scientific"];
    images = json["images"];
    recipes = json["recipes"];
    description = json["description"];
    key = key;
  }

  Map<String, dynamic> toJson() => {
        "common": commonName,
        "scientific": scientificName,
        "images": images,
        "recipes": recipes,
        "description": description,
      };

  Plant(this.commonName, this.scientificName, this.images, this.recipes,
      this.description, this.key);
}

class PlantPage extends StatefulWidget {
  Plant plant;
  Map<String, Garden> gardens;

  PlantPage({
    super.key,
    required this.plant,
    required this.gardens,
  });

  @override
  State<PlantPage> createState() => _PlantPageState();
}

class PlantsPage extends StatefulWidget {
  Map<String, Garden> gardens = {};
  Map<String, Plant> plants = {};

  PlantsPage({
    super.key,
    required this.gardens,
    required this.plants,
  });

  @override
  State<PlantsPage> createState() => _PlantsPageState();
}

class _PlantPageState extends State<PlantPage> {
  @override
  Widget build(BuildContext context) {
    List<Widget> images = List<Widget>.empty(growable: true);
    for (dynamic path in widget.plant.images) {
      images.add(Image.network(path.toString()));
    }
    return Scaffold(
        appBar: AppBar(title: Text(widget.plant.commonName)),
        body: Column(children: [
          Expanded(
              flex: 40,
              child:
                  ListView(scrollDirection: Axis.horizontal, children: images)),
          Expanded(
            flex: 60,
            child: ListView(children: [
              const Text("Common Name",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              ListTile(leading: Text(widget.plant.commonName)),
              const Text("Scientific Name",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              ListTile(leading: Text(widget.plant.scientificName)),
              const Text("Recipes",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              ListTile(leading: Text(widget.plant.recipes)),
              const Text("Description",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              ListTile(leading: Text(widget.plant.description)),
            ]),
          )
        ]));
  }
}

class _PlantsPageState extends State<PlantsPage> {
  @override
  Widget build(BuildContext context) {
    List<Widget> plantTiles = List.empty(growable: true);
    for (var p in widget.plants.values) {
      plantTiles.add(ListTile(
          title: Text(p.commonName),
          trailing: const Icon(Icons.more_vert),
          onTap: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) =>
                    PlantPage(plant: p, gardens: widget.gardens)));
          }));
    }
    return Scaffold(
      appBar: AppBar(title: const Text("Plants")),
      body: ListView(padding: EdgeInsets.zero, children: plantTiles),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
    );
  }
}
