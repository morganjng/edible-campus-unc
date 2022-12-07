import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'ecdata.dart';
import 'plant.dart';
import 'garden.dart';

void main() async {
  await getData();
  runApp(Portal());
}

List<String> entries = ["", "", "", "", "", "", "", ""];

ECData data = ECData.empty();
ThemeData theme = ThemeData(
    backgroundColor: const Color(0xFFFFFFFF),
    tabBarTheme: const TabBarTheme(
      labelColor: Color(0xFF04AA6D),
      unselectedLabelColor: Color(0xFFFFFFFF),
    ));

Map<String, dynamic>? _serverData;

Future<bool> getData() async {
  // TODO hash checking with webserver and pulling diffs
  // TODO actually pull (maybe from test server first? at edible_campus_unc/test_server.py)
  //_serverData = jsonDecode(File("edible_campus_data.json").readAsStringSync());
  var rl = await http.get(Uri.parse(
      'https://edible-campus-unc-server-gribbins.apps.cloudapps.unc.edu/data/latest'));

  if (rl.statusCode == 200) {
    _serverData = jsonDecode(rl.body);
    var sd = _serverData!;

    data = ECData.fromJson(sd);

    return true;
  } else {
    throw Exception("Failed to get data");
  }
}

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Expanded(flex: 80, child: Text(data.toJson().toString())),
      TextButton(
          child: const Text("POST"),
          onPressed: () {
            http.post(
                Uri.parse(
                    "https://edible-campus-unc-server-gribbins.apps.cloudapps.unc.edu/data/post"),
                body: jsonEncode(data));
          })
    ]));
  }
}

class Portal extends StatefulWidget {
  Widget rightHand = const Expanded(flex: 80, child: HelpPage());

  Portal({super.key});

  @override
  State<Portal> createState() => PortalState();
}

class PortalState extends State<Portal> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Edible Campus UNC Admin Portal",
      theme: theme,
      home: Scaffold(
          body: Column(children: [
        Expanded(
            flex: 20,
            child: Material(
                color: const Color(0xFFFFFFFF),
                child: Image.network(
                    "https://ncbg.unc.edu/wp-content/uploads/sites/963/2020/08/EC-Logo-Final-1-768x498.jpg"))),
        Expanded(
            flex: 80,
            child: DefaultTabController(
                length: 6,
                child: Scaffold(
                    appBar: const PreferredSize(
                        preferredSize: Size(100, 100),
                        child: Material(
                            color: Color(0xFF333333),
                            child: TabBar(tabs: [
                              Tab(child: Text("Help")),
                              Tab(child: Text("Add a Plant")),
                              Tab(child: Text("Add a Garden")),
                              Tab(child: Text("Edit a Plant")),
                              Tab(child: Text("Edit a Garden")),
                              Tab(child: Text("Settings"))
                            ]))),
                    body: TabBarView(children: [
                      const HelpPage(),
                      AddPlantPage(),
                      AddGardenPage(),
                      const EditPlantPage(),
                      const EditGardenPage(),
                      const SettingsPage(),
                    ]))))
      ])),
    );
  }
}

class AddPlantPage extends StatefulWidget {
  List<String> entries = [
    "",
    "",
    "",
    "",
    "",
  ];

  AddPlantPage({super.key});

  void submit() {}

  @override
  State<AddPlantPage> createState() => _AddPlantPageState();
}

class _AddPlantPageState extends State<AddPlantPage> {
  @override
  Widget build(BuildContext context) {
    List<Widget> dataFields = [
      TextField(
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
        ),
        textAlign: TextAlign.center,
        onChanged: (text) {
          widget.entries[0] = text;
        },
        onSubmitted: (text) {
          widget.entries[0] = text;
        },
      ),
      TextField(
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
        ),
        textAlign: TextAlign.center,
        onChanged: (text) {
          widget.entries[1] = text;
        },
        onSubmitted: (text) {
          widget.entries[1] = text;
        },
      ),
      TextField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.multiline,
        maxLines: null,
        onChanged: (text) {
          widget.entries[2] = text;
        },
        onSubmitted: (text) {
          widget.entries[2] = text;
        },
      ),
      TextField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.multiline,
        maxLines: null,
        onChanged: (text) {
          widget.entries[3] = text;
        },
        onSubmitted: (text) {
          widget.entries[3] = text;
        },
      ),
      TextField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.multiline,
          maxLines: null,
          onChanged: (text) {
            widget.entries[4] = text;
          },
          onSubmitted: (text) {
            widget.entries[4] = text;
          }),
    ];

    TextButton saveButton = TextButton(
        style: TextButton.styleFrom(
          backgroundColor: const Color(0xFF333333),
          foregroundColor: const Color(0xFFFFFFFF),
        ),
        child: const Text("Save"),
        onPressed: () {
          if (widget.entries[0] != "" &&
              widget.entries[1] != "" &&
              widget.entries[2] != "" &&
              widget.entries[3] != "" &&
              widget.entries[4] != "") {
            data.plants[widget.entries[0].toLowerCase()] = Plant(
                widget.entries[0],
                widget.entries[1],
                parseStringToList(widget.entries[4]),
                widget.entries[2],
                widget.entries[3],
                widget.entries[0].toLowerCase());
          }
        });

    return Row(children: [
      Expanded(flex: 10, child: Container()),
      Expanded(
          flex: 80,
          child: ListView(children: [
            const Padding(
                padding: EdgeInsets.all(8.0), child: Text("Plant Common Name")),
            Padding(padding: const EdgeInsets.all(8.0), child: dataFields[0]),
            const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Plant Scientific Name")),
            Padding(padding: const EdgeInsets.all(8.0), child: dataFields[1]),
            const Padding(padding: EdgeInsets.all(8.0), child: Text("Recipes")),
            Padding(padding: const EdgeInsets.all(8.0), child: dataFields[2]),
            const Padding(
                padding: EdgeInsets.all(8.0), child: Text("Description")),
            Padding(padding: const EdgeInsets.all(8.0), child: dataFields[3]),
            const Padding(
                padding: EdgeInsets.all(8.0), child: Text("Image hyperlinks")),
            Padding(padding: const EdgeInsets.all(8.0), child: dataFields[4]),
            Padding(padding: const EdgeInsets.all(8.0), child: saveButton)
          ])),
      Expanded(flex: 10, child: Container())
    ]);
  }
}

class AddGardenPage extends StatefulWidget {
  List<String> entries = [
    "",
    "",
    "",
    "",
  ];

  AddGardenPage({super.key});

  @override
  State<AddGardenPage> createState() => _AddGardenPageState();
}

class _AddGardenPageState extends State<AddGardenPage> {
  @override
  Widget build(BuildContext context) {
    List<Widget> dataFields = [
      TextField(
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
        ),
        textAlign: TextAlign.center,
        onChanged: (text) {
          widget.entries[0] = text;
        },
        onSubmitted: (text) {
          widget.entries[0] = text;
        },
      ),
      TextField(
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
        ),
        textAlign: TextAlign.center,
        onChanged: (text) {
          widget.entries[1] = text;
        },
        onSubmitted: (text) {
          widget.entries[1] = text;
        },
      ),
      TextField(
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
        ),
        keyboardType: TextInputType.multiline,
        maxLines: null,
        onChanged: (text) {
          widget.entries[2] = text;
        },
        onSubmitted: (text) {
          widget.entries[2] = text;
        },
      ),
      TextField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.multiline,
        maxLines: null,
        onChanged: (text) {
          widget.entries[3] = text;
        },
        onSubmitted: (text) {
          widget.entries[3] = text;
        },
      ),
    ];

    TextButton saveButton = TextButton(
        style: TextButton.styleFrom(
          backgroundColor: const Color(0xFF333333),
          foregroundColor: const Color(0xFFFFFFFF),
        ),
        child: const Text("Save"),
        onPressed: () {
          if (widget.entries[0] != "" &&
              widget.entries[1] != "" &&
              widget.entries[2] != "" &&
              widget.entries[3] != "") {
            data.gardens[widget.entries[0].toLowerCase()] = Garden(
                widget.entries[0],
                double.parse(widget.entries[1]),
                double.parse(widget.entries[2]),
                [],
                parseStringToList(widget.entries[3]),
                widget.entries[0].toLowerCase());
          }
        });

    return Row(children: [
      Expanded(flex: 10, child: Container()),
      Expanded(
          flex: 80,
          child: ListView(children: [
            const Padding(
                padding: EdgeInsets.all(8.0), child: Text("Garden Title")),
            Padding(padding: const EdgeInsets.all(8.0), child: dataFields[0]),
            const Padding(
                padding: EdgeInsets.all(8.0), child: Text("Latitude")),
            Padding(padding: const EdgeInsets.all(8.0), child: dataFields[1]),
            const Padding(
                padding: EdgeInsets.all(8.0), child: Text("Longitude")),
            Padding(padding: const EdgeInsets.all(8.0), child: dataFields[2]),
            const Padding(
                padding: EdgeInsets.all(8.0), child: Text("Image hyperlinks")),
            Padding(padding: const EdgeInsets.all(8.0), child: dataFields[3]),
            Padding(padding: const EdgeInsets.all(8.0), child: saveButton)
          ])),
      Expanded(flex: 10, child: Container())
    ]);
  }
}

class EditPlantPage extends StatefulWidget {
  const EditPlantPage({super.key});

  @override
  State<EditPlantPage> createState() => _EditPlantPageState();
}

class _EditPlantPageState extends State<EditPlantPage> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(flex: 10, child: Container()),
      Expanded(flex: 80, child: data.plantsPage()),
      Expanded(flex: 10, child: Container())
    ]);
  }
}

class EditGardenPage extends StatefulWidget {
  const EditGardenPage({super.key});

  @override
  State<EditGardenPage> createState() => _EditGardenPageState();
}

class _EditGardenPageState extends State<EditGardenPage> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(flex: 10, child: Container()),
      Expanded(flex: 80, child: data.gardensPage()),
      Expanded(flex: 10, child: Container())
    ]);
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.sledding);
  }
}

List<String> parseStringToList(String text) {
  List<String> rv = List<String>.empty(growable: true);
  // TODO this ^
  rv.add(text);
  return rv;
}
