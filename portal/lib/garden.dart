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
        "images": images,
      };

  Garden(this.title, this.latitude, this.longitude, this.plants, this.images,
      this.key);
}

class GardenPage extends StatefulWidget {
  Garden garden;
  String dropdownValue0 = "";
  String dropdownValue1 = "";
  List<String> entries = ["", "", "", ""];
  Map<String, Garden> gardens;
  Map<String, Plant> plants;
  Widget rightHand =
      const Expanded(flex: 50, child: Icon(Icons.energy_savings_leaf));
  List<DropdownButton> dropdowns = List<DropdownButton>.empty(growable: true);

  List<DropdownMenuItem> allplants =
      List<DropdownMenuItem>.empty(growable: true);
  List<DropdownMenuItem> myplants =
      List<DropdownMenuItem>.empty(growable: true);

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
  Widget rightHand = const Expanded(flex: 50, child: Icon(Icons.ice_skating));

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
    List<TextField> dataFields = [
      TextField(
        decoration: InputDecoration(
            border: const UnderlineInputBorder(),
            hintText: widget.garden.title),
        textAlign: TextAlign.center,
        onChanged: (text) {
          widget.entries[0] = text;
        },
        onSubmitted: (text) {
          widget.entries[0] = text;
        },
      ),
      TextField(
        decoration: InputDecoration(
            border: const UnderlineInputBorder(),
            hintText: widget.garden.latitude.toString()),
        textAlign: TextAlign.center,
        onChanged: (text) {
          widget.entries[1] = text;
        },
        onSubmitted: (text) {
          widget.entries[1] = text;
        },
      ),
      TextField(
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: widget.garden.longitude.toString()),
        textAlign: TextAlign.center,
        onChanged: (text) {
          widget.entries[2] = text;
        },
        onSubmitted: (text) {
          widget.entries[2] = text;
        },
      ),
    ];

    List<TextButton> saveButtons = [
      TextButton(
        style: TextButton.styleFrom(
          backgroundColor: const Color(0xFF333333),
          foregroundColor: const Color(0xFFFFFFFF),
        ),
        child: const Text("Save"),
        onPressed: () {
          setState(() {
            if (widget.entries[0] != "") {
              widget.garden.title = widget.entries[0];
            }
            if (widget.entries[1] != "") {
              widget.garden.latitude = double.parse(widget.entries[1]);
            }
            if (widget.entries[2] != "") {
              widget.garden.longitude = double.parse(widget.entries[2]);
            }
            if (widget.entries[3] != "") {
              // TODO do images
            }
          });
        },
      ),
      TextButton(
        style: TextButton.styleFrom(
          backgroundColor: const Color(0xFF333333),
          foregroundColor: const Color(0xFFFFFFFF),
        ),
        child: const Text("Add"),
        onPressed: () {
          setState(() {
            widget.garden.plants.add(widget.dropdownValue0);
            widget.myplants.clear();
          });
        },
      ),
      TextButton(
        style: TextButton.styleFrom(
          backgroundColor: const Color(0xFF333333),
          foregroundColor: const Color(0xFFFFFFFF),
        ),
        child: const Text("Remove"),
        onPressed: () {
          setState(() {
            widget.myplants.clear();
            widget.garden.plants.remove(widget.dropdownValue1);
          });
        },
      )
    ];

    if (widget.allplants.isEmpty) {
      for (String key in widget.plants.keys) {
        widget.dropdownValue0 = key;
        widget.allplants.add(DropdownMenuItem(value: key, child: Text(key)));
      }
    }

    if (widget.myplants.isEmpty) {
      for (String key in widget.garden.plants) {
        widget.dropdownValue1 = key;
        widget.myplants.add(DropdownMenuItem(
          value: key,
          child: Text(key),
        ));
      }
    }

    widget.myplants.map((va) => {print(va.value)});

    if (widget.dropdowns.isEmpty) {
      widget.dropdowns.add(DropdownButton(
          items: widget.allplants,
          onChanged: (dynamic value) {
            setState(() {
              widget.dropdownValue0 = value.toString();
            });
          },
          value: widget.dropdownValue0.toString()));
      widget.dropdowns.add(DropdownButton(
        items: widget.myplants,
        onChanged: (dynamic value) {
          setState(() {
            widget.dropdownValue1 = value.toString();
          });
        },
        value: widget.dropdownValue1.toString(),
      ));
    } else {
      widget.dropdowns[0] = DropdownButton(
          items: widget.allplants,
          onChanged: (dynamic value) {
            setState(() {
              widget.dropdownValue0 = value.toString();
            });
          },
          value: widget.dropdownValue0.toString());
      widget.dropdowns[1] = DropdownButton(
        items: widget.myplants,
        onChanged: (dynamic value) {
          setState(() {
            widget.dropdownValue1 = value.toString();
          });
        },
        value: widget.dropdownValue1.toString(),
      );
    }

    return Row(children: [
      Expanded(flex: 10, child: Container()),
      Expanded(
          flex: 80,
          child: Column(children: [
            const Padding(padding: EdgeInsets.all(8.0), child: Text("Title")),
            Padding(padding: const EdgeInsets.all(8.0), child: dataFields[0]),
            const Padding(
                padding: EdgeInsets.all(8.0), child: Text("Latitude")),
            Padding(padding: const EdgeInsets.all(8.0), child: dataFields[1]),
            const Padding(
                padding: EdgeInsets.all(8.0), child: Text("Longitude")),
            Padding(padding: const EdgeInsets.all(8.0), child: dataFields[2]),
            Padding(padding: const EdgeInsets.all(8.0), child: saveButtons[0]),
            const Padding(
                padding: EdgeInsets.all(8.0), child: Text("Add a plant")),
            Row(
              children: [
                Expanded(
                    flex: 70,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: widget.dropdowns[0])),
                Expanded(
                    flex: 30,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: saveButtons[1]))
              ],
            ),
            const Padding(
                padding: EdgeInsets.all(8.0), child: Text("Remove a plant")),
            Row(
              children: [
                Expanded(
                    flex: 70,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: widget.dropdowns[1])),
                Expanded(
                    flex: 30,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: saveButtons[2]))
              ],
            ),
          ])),
      Expanded(flex: 10, child: Container())
    ]);
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
