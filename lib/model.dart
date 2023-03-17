// ignore_for_file: file_names, avoid_print, unrelated_type_equality_checks

import 'dart:convert';

import 'package:breadcrumbs/meter_reading.dart';
import 'package:breadcrumbs/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Model extends StatefulWidget {
  const Model({
    super.key,
    Key? required,
    required this.makeName,
    required this.makeId,
  });

  final String makeName;
  final String makeId;
  @override
  State<Model> createState() => _ModelState();
}

class _ModelState extends State<Model> {
  List<String> data = [];
  int initPosition = 0;
  List<Map<String, dynamic>> dummyListData = [];
  String make = "";
  String model = "";
  String hpRange = "";
  String meterReading = "";

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  getAllModels(id) async {
    // ignore: avoid_init_to_null, unused_local_variable

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("model") != null) {
      model = sharedPreferences.getString("model")!;
    }

    if (sharedPreferences.getString("hpRange") != null) {
      hpRange = sharedPreferences.getString("hpRange")!;
    }

    if (sharedPreferences.getString("meterReading") != null) {
      meterReading = sharedPreferences.getString("meterReading")!;
    }

    setState(() {
      _isLoading = false;
    });
    var jsonResponse = null;
    Map data = {
      'id': id,
    };
    var response = await http.post(
        Uri.parse(
            "https://rapidbid.meratractor.com/auction/model-name-get-all-flutter"),
        headers: {'Accept': 'application/json'},
        body: data);

    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);

      jsonResponse.forEach((car, data) {
        dummyListData.add(data);
      });
      setState(() {});
    } else {
      throw Exception('Failed to load data!');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      getAllModels(widget.makeId);
      setState(() {
        make = widget.makeName;
      });
    }

    if (dummyListData.isNotEmpty) {
      setState(() {
        _isLoading = false;
      });
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Text(
                "rapibid",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              const PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.logout),
                  title: Text(
                    'Logout',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(0),
                child: Wrap(
                  spacing: 1,
                  runSpacing: 1,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      child: Chip(
                        labelPadding: const EdgeInsets.all(2.0),
                        label: Text(
                          widget.makeName.isNotEmpty ? widget.makeName : "make",
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        backgroundColor: Colors.white,
                        elevation: 6.0,
                        shadowColor: Colors.grey[60],
                        padding: const EdgeInsets.all(8.0),
                      ),
                      onTap: () {
                        context.goNamed(AppRoute.make.name, params: {
                          "makeName": widget.makeName.toString(),
                        });
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      child: Chip(
                        labelPadding: const EdgeInsets.all(2.0),
                        label: Text(
                          model.isNotEmpty ? model : "model",
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        backgroundColor: Colors.white,
                        elevation: 6.0,
                        shadowColor: Colors.grey[60],
                        padding: const EdgeInsets.all(8.0),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      child: Chip(
                        labelPadding: const EdgeInsets.all(2.0),
                        label: Text(
                          hpRange.isNotEmpty ? hpRange : "HP Range",
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        backgroundColor: Colors.white,
                        elevation: 6.0,
                        shadowColor: Colors.grey[60],
                        padding: const EdgeInsets.all(8.0),
                      ),
                      onTap: () {
                        context.goNamed(AppRoute.hpRange.name, params: {
                          "makeName": widget.makeName.toString(),
                          "makeId": widget.makeId.toString(),
                          "modelName": model.toString(),
                        });
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      child: Chip(
                        labelPadding: const EdgeInsets.all(2.0),
                        label: Text(
                          meterReading.isNotEmpty
                              ? meterReading
                              : "Meter Reading",
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        backgroundColor: Colors.white,
                        elevation: 6.0,
                        shadowColor: Colors.grey[60],
                        padding: const EdgeInsets.all(8.0),
                      ),
                      onTap: () {
                        context.goNamed(AppRoute.meterReading.name, params: {
                          "makeName": widget.makeName.toString(),
                          "makeId": widget.makeId.toString(),
                          "hpRange": hpRange.toString(),
                          "modelName": model.toString(),
                        });
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Chip(
                      labelPadding: const EdgeInsets.all(2.0),
                      label: const Text(
                        "make",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      backgroundColor: Colors.white,
                      elevation: 6.0,
                      shadowColor: Colors.grey[60],
                      padding: const EdgeInsets.all(8.0),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Chip(
                      labelPadding: const EdgeInsets.all(2.0),
                      label: const Text(
                        "make",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      backgroundColor: Colors.white,
                      elevation: 6.0,
                      shadowColor: Colors.grey[60],
                      padding: const EdgeInsets.all(8.0),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Chip(
                      labelPadding: const EdgeInsets.all(2.0),
                      label: const Text(
                        "make",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      backgroundColor: Colors.white,
                      elevation: 6.0,
                      shadowColor: Colors.grey[60],
                      padding: const EdgeInsets.all(8.0),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.grey[300],
                margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // backgroundColor: Colors.black,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Select Model",
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 160, 0, 0),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: dummyListData.isEmpty
                  ? const SizedBox(
                      height: 100,
                      width: 100,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : ListView.builder(
                      itemCount: dummyListData.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: const BoxDecoration(
                              border: Border(bottom: BorderSide(width: 0.7))),
                          child: ListTile(
                            title: Text(
                              dummyListData[index]["model_name"],
                              style: const TextStyle(fontSize: 20),
                            ),
                            onTap: () async {
                              setState(() {
                                model = dummyListData[index]["model_name"];
                              });

                              if (dummyListData != Null) {
                                context.goNamed(AppRoute.hpRange.name, params: {
                                  "makeName": dummyListData[index]["make_name"].toString(),
                                  "makeId": widget.makeId.toString(),
                                  "modelName": dummyListData[index]["model_name"].toString(),
                                });
                              }
                              SharedPreferences sharedPreferences =
                                  await SharedPreferences.getInstance();
                              sharedPreferences.setString(
                                  "make", dummyListData[index]["make_name"]);
                              sharedPreferences.setString(
                                  "model", dummyListData[index]["model_name"]);
                            },
                          ),
                        );
                      },
                    ),
            ),
          )
        ],
      ),
    );
  }
}
