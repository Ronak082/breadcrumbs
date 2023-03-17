// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:convert';

import 'package:breadcrumbs/meter_reading.dart';
import 'package:breadcrumbs/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Make extends StatefulWidget {
  const Make({super.key, required String makeName});

  @override
  _MakeState createState() => _MakeState();
}

class _MakeState extends State<Make> {
  List<String> data = [];
  int initPosition = 0;
  List<Map<String, dynamic>> dummyListData = [];
  String make = "";
  String model = "";
  String makeId = "";
  String hpRange = "";
  String meterReading = "";

  String currentState = "";

  @override
  void initState() {
    super.initState();
    getAllMakes();
    getSelectedMake();
  }

  getSelectedMake() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("make") != null) {
      make = sharedPreferences.getString("make")!;
    }

    if (sharedPreferences.getString("makeId") != null) {
      makeId = sharedPreferences.getString("makeId")!;
    }

    if (sharedPreferences.getString("model") != null) {
      model = sharedPreferences.getString("model")!;
    }

    if (sharedPreferences.getString("hpRange") != null) {
      hpRange = sharedPreferences.getString("hpRange")!;
    }

    if (sharedPreferences.getString("meterReading") != null) {
      meterReading = sharedPreferences.getString("meterReading")!;
    }

    setState(() {});
  }

  getAllMakes() async {
    // ignore: avoid_init_to_null, unused_local_variable
    var jsonResponse = null;
    var response = await http.post(
        Uri.parse(
            "https://rapibid.meratractor.com/auction/make-get-all-flutter"),
        headers: {'Accept': 'application/json'});

    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);

      // dummyListData.add(jsonResponse);
      jsonResponse.forEach((car, data) {
        dummyListData.add(data);
      });
      setState(() {});
    } else {
      throw Exception('Failed to load data!');
    }
  }
  
  @override
  Widget build( context) {
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
                          make.isNotEmpty ? make : "make",
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
                      onTap: () {
                        context.goNamed(AppRoute.model.name, params: {
                          "makeName": make.toString(),
                          "makeId": makeId.toString(),
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
                          "makeName": make.toString(),
                          "makeId": makeId.toString(),
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
                          "makeName": make.toString(),
                          "makeId": makeId.toString(),
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
                        "Select Make",
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
                                dummyListData[index]["name"],
                                style: const TextStyle(fontSize: 20),
                              ),
                              onTap: () async {
                                setState(() {
                                  make = dummyListData[index]["name"];
                                  makeId =
                                      dummyListData[index]["id"].toString();
                                });

                                SharedPreferences sharedPreferences =
                                    await SharedPreferences.getInstance();

                                if (sharedPreferences.getString("make") !=
                                    dummyListData[index]["name"]) {
                                  sharedPreferences.setString("model", "");
                                }
                                sharedPreferences.setString(
                                    "make", dummyListData[index]["name"]);
                                sharedPreferences.setString("makeId",
                                    dummyListData[index]["id"].toString());

                                // ignore: unrelated_type_equality_checks
                                if (dummyListData != Null) {
                                  context.goNamed(AppRoute.model.name , params: {
                                    "makeName":
                                        dummyListData[index]["name"].toString(),
                                    "makeId":
                                        dummyListData[index]["id"].toString()
                                  });
                                }
                              },
                            ),
                          );
                        },
                      ),
              ))
        ],
      ),
    );
  }
}