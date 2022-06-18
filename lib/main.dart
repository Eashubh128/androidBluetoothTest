// Copyright 2017, Paul DeMarco.
// All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

void main() {
  runApp(const MaterialApp(home: FlutterBlueApp()));
}

class FlutterBlueApp extends StatefulWidget {
  const FlutterBlueApp({Key? key}) : super(key: key);

  @override
  State<FlutterBlueApp> createState() => _FlutterBlueAppState();
}

class _FlutterBlueAppState extends State<FlutterBlueApp> {
  int ctr = 0;
  late FlutterBlue flutterBlue;
  @override
  initState() {
    super.initState();
    flutterBlue = FlutterBlue.instance;
    log("done");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Looking For devices"),
      ),
      body: Text(
        "$ctr",
        style: TextStyle(fontSize: 100),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          // Start scanning
          flutterBlue.startScan(timeout: Duration(seconds: 4));

// Listen to scan results
          var subscription = flutterBlue.scanResults.listen((results) {
            // do something with scan results
            for (ScanResult r in results) {
              log("$r");
              // log('${r.device.name} found! ${r.rssi}');
            }
          });

// Stop scanning
        },
      ),
    );
  }
}
