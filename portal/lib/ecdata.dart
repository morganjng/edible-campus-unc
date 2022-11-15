import 'package:flutter/material.dart';

class ECData {
  Map<String, Plant> plants = {};
  Map<String, Garden> gardens = {};

  ECData(Map<String, dynamic> jsonData) {
    for (int i = 0; i < jsonData["plant_keys"].length; i++) {
      plants[jsonData["plant_keys"][i].toString()] = Plant(
        jsonData["plant"][jsonData["plant_keys"][i].toString()]["common"]
            .toString(),
        jsonData["plant"][jsonData["plant_keys"][i].toString()]["scientific"]
            .toString(),
        jsonData["plant"][jsonData["plant_keys"][i].toString()]["images"]
            .toList(),
        jsonData["plant"][jsonData["plant_keys"][i].toString()]["recipes"]
            .toString(),
        jsonData["plant"][jsonData["plant_keys"][i].toString()]["description"]
            .toString(),
      );
    }
    for (int i = 0; i < jsonData["garden_keys"].length; i++) {
      gardens[jsonData["garden_keys"][i].toString()] = Garden(
        jsonData["garden"][jsonData["garden_keys"][i].toString()]["title"]
            .toString(),
        jsonData["garden"][jsonData["garden_keys"][i].toString()]["latitude"]
            .toDouble(),
        jsonData["garden"][jsonData["garden_keys"][i].toString()]["longitude"]
            .toDouble(),
        jsonData["garden"][jsonData["garden_keys"][i].toString()]["plants"]
            .toList(),
        jsonData["garden"][jsonData["garden_keys"][i].toString()]["images"]
            .toList(),
      );
    }
  }

  ECData.empty();

  GardenPage gardenPage(String key) {
    return GardenPage(garden: gardens[key]!, plants: plants, gardens: gardens);
  }

  GardensPage gardensPage() {
    return GardensPage(gardens: gardens, plants: plants);
  }

  PlantPage plantPage(String key) {
    return PlantPage(plant: plants[key]!, gardens: gardens);
  }

  PlantsPage plantsPage() {
    return PlantsPage(gardens: gardens, plants: plants);
  }
}

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

  GardenPage(
      {super.key,
      required this.garden,
      required this.gardens,
      required this.plants});

  @override
  State<GardenPage> createState() => _GardenPageState();
}

class GardensPage extends StatefulWidget {
  static List<Widget> gardenTiles = List<Widget>.empty(growable: true);
  Map<String, Garden> gardens;

  Map<String, Plant> plants;

  GardensPage({super.key, required this.gardens, required this.plants});

  @override
  State<GardensPage> createState() => _GardensPageState();
}

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

  PlantPage({super.key, required this.plant, required this.gardens});

  @override
  State<PlantPage> createState() => _PlantPageState();
}

class PlantsPage extends StatefulWidget {
  Map<String, Garden> gardens = {};
  Map<String, Plant> plants = {};

  PlantsPage({super.key, required this.gardens, required this.plants});

  @override
  State<PlantsPage> createState() => _PlantsPageState();
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
                      gardens: widget.gardens)));
        }));

    for (int i = 1; i < widget.garden.plants.length; i++) {
      ps.add(ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PlantPage(
                        plant: widget.plants[widget.garden.plants[i]]!,
                        gardens: widget.gardens)));
          },
          trailing: Text(widget.plants[widget.garden.plants[i]]!.commonName)));
    }

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
    if (GardensPage.gardenTiles.isEmpty) {
      for (var b in widget.gardens.values) {
        GardensPage.gardenTiles.add(ListTile(
            title: Text(b.title),
            trailing: const Icon(Icons.more_vert),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GardenPage(
                          garden: b,
                          gardens: widget.gardens,
                          plants: widget.plants)));
            }));
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Gardens")),
      body:
          ListView(padding: EdgeInsets.zero, children: GardensPage.gardenTiles),
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
        ]),
        appBar: AppBar(title: Text(widget.plant.commonName)));
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
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PlantPage(
                          plant: p,
                          gardens: widget.gardens,
                        )));
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
