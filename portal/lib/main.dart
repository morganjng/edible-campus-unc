import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'ecdata.dart';

void main() async {
  await getData();
  runApp(Portal());
}

ECData data = ECData.empty();
ThemeData theme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF62C6F2)));

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

    data = ECData(sd);

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
    return Scaffold(body: Column(children: const []));
  }
}

class Portal extends StatefulWidget {
  Widget rightHand = Expanded(flex: 80, child: HelpPage());

  Portal({super.key});

  @override
  State<Portal> createState() => PortalState();
}

class PortalState extends State<Portal> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Edible Campus Admin Portal",
      theme: theme,
      home: Scaffold(
          body: Row(
        children: <Widget>[
          Expanded(
              flex: 20,
              child: ListView(padding: EdgeInsets.zero, children: [
                ListTile(
                    title: const Text("Help"),
                    onTap: () {
                      setState(() {
                        widget.rightHand =
                            const Expanded(flex: 80, child: HelpPage());
                      });
                    }),
                ListTile(
                    title: const Text("Plants"),
                    onTap: () {
                      setState(() {
                        widget.rightHand =
                            Expanded(flex: 80, child: data.plantsPage());
                      });
                    }),
                ListTile(
                  title: const Text("Gardens"),
                  onTap: () {
                    setState(() {
                      widget.rightHand =
                          Expanded(flex: 80, child: data.gardensPage());
                    });
                  },
                ),
                const ListTile(title: Text("Settings"))
              ])),
          widget.rightHand,
        ],
      )),
      // routes: {
      //   "/": (context) => HelpPage(),
      //   "/plants": (context) => data.plantsPage(),
      //   "/gardens": (context) => data.gardensPage(),
      // }
    );
  }
}
