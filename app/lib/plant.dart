import 'package:flutter/material.dart';
import 'garden.dart';

class Plant {
  String commonName;
  String scientificName;
  List<dynamic> images;
  String recipes;
  String description;

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
      bottomNavigationBar:
          BottomNavigationBar(items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.crib), label: "Gardens"),
        BottomNavigationBarItem(icon: Icon(Icons.yard), label: "Plants"),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle), label: "Account")
      ], currentIndex: 0, onTap: null),
    );
  }
}
