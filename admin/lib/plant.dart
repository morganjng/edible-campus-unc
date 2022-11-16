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
  List<TextField> dataFields = [
    const TextField(
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
      ),
      textAlign: TextAlign.center,
    ),
    const TextField(
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
      ),
      textAlign: TextAlign.center,
    ),
    const TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.multiline,
      maxLines: null,
    ),
    const TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.multiline,
      maxLines: null,
    ),
    const TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.multiline,
      maxLines: null,
    ),
  ];
  TextButton saveButton = TextButton(
    style: TextButton.styleFrom(
      backgroundColor: const Color(0xFF333333),
      foregroundColor: const Color(0xFFFFFFFF),
    ),
    child: const Text("Save"),
    onPressed: () {},
  );

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
    widget.dataFields[0] = TextField(
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        hintText: widget.plant.commonName,
      ),
      textAlign: TextAlign.center,
    );
    widget.dataFields[1] = TextField(
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        hintText: widget.plant.scientificName,
      ),
      textAlign: TextAlign.center,
    );
    widget.dataFields[2] = TextField(
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        hintText: widget.plant.recipes,
      ),
      textAlign: TextAlign.center,
    );
    widget.dataFields[3] = TextField(
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        hintText: widget.plant.description,
      ),
      textAlign: TextAlign.center,
    );

    return Row(children: [
      Expanded(flex: 10, child: Container()),
      Expanded(
          flex: 80,
          child: Column(children: [
            const Padding(
                padding: EdgeInsets.all(8.0), child: Text("Common Name")),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: widget.dataFields[0]),
            const Padding(
                padding: EdgeInsets.all(8.0), child: Text("Scientific Name")),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: widget.dataFields[1]),
            const Padding(padding: EdgeInsets.all(8.0), child: Text("Recipes")),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: widget.dataFields[2]),
            const Padding(
                padding: EdgeInsets.all(8.0), child: Text("Description")),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: widget.dataFields[3]),
            const Padding(
                padding: EdgeInsets.all(8.0), child: Text("Image hyperlinks")),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: widget.dataFields[4]),
            Padding(
                padding: const EdgeInsets.all(8.0), child: widget.saveButton)
          ])),
      Expanded(flex: 10, child: Container())
    ]);
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
