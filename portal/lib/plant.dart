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
      this.description);
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
  Widget rightHand = Expanded(flex: 50, child: Icon(Icons.sledding));
  List<Widget> plantTiles = List.empty(growable: true);

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
    return Scaffold(
        body: Row(children: [
      Column(children: const [
        Text("Common Name",
            textAlign: TextAlign.left,
            style: TextStyle(fontWeight: FontWeight.bold)),
        Text("Scientific Name",
            textAlign: TextAlign.left,
            style: TextStyle(fontWeight: FontWeight.bold)),
        Text("Recipes",
            textAlign: TextAlign.left,
            style: TextStyle(fontWeight: FontWeight.bold)),
        Text("Description",
            textAlign: TextAlign.left,
            style: TextStyle(fontWeight: FontWeight.bold)),
      ]),
      Column(children: [
        Text(widget.plant.commonName, textAlign: TextAlign.right),
        Text(widget.plant.scientificName, textAlign: TextAlign.right),
        Text(widget.plant.recipes, textAlign: TextAlign.right),
        Text(widget.plant.description, textAlign: TextAlign.right),
      ])
    ]));
  }
}

class _PlantsPageState extends State<PlantsPage> {
  @override
  Widget build(BuildContext context) {
    if (widget.plantTiles.isEmpty) {
      for (var p in widget.plants.values) {
        widget.plantTiles.add(ListTile(
            title: Text(p.commonName),
            trailing: const Icon(Icons.more_vert),
            onTap: () {
              setState(() {
                widget.rightHand = Expanded(
                    flex: 50,
                    child: PlantPage(
                      plant: p,
                      gardens: widget.gardens,
                    ));
              });
            }));
      }
    }
    return Scaffold(
        body: Row(
      children: [
        Expanded(
            flex: 50,
            child: ListView(
                padding: EdgeInsets.zero, children: widget.plantTiles)),
        widget.rightHand,
      ],
    ));
  }
}
