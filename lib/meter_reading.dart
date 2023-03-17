// ignore_for_file: file_names, avoid_print

import 'package:breadcrumbs/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MeterReading extends StatefulWidget {
  const MeterReading({
    super.key,
    Key? required,
    required this.makeName,
    required this.makeId,
    required this.modelName,
    required this.hpRange,
  });

  final String makeName;
  final String makeId;
  final String modelName;
  final String hpRange;
  @override
  State<MeterReading> createState() => _MeterReadingState();
}

class _MeterReadingState extends State<MeterReading> {
  List<String> data = [];
  int initPosition = 0;
  List<Map<String, dynamic>> dummyListData = [
    {"id": "yes", "range": "Yes"},
    {"id": "no", "range": "No"},
  ];

  String meterReading = "";

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.getString("meterReading") != null) {
      meterReading = sharedPreferences.getString("meterReading")!;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (dummyListData.isNotEmpty) {
      setState(() {});
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
                          widget.modelName.isNotEmpty
                              ? widget.modelName
                              : "model",
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
                          "makeName": widget.makeName.toString(),
                          "makeId": widget.makeId.toString(),
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
                          widget.hpRange.isNotEmpty
                              ? widget.hpRange
                              : "HP Range",
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
                          "modelName": widget.modelName.toString(),
                        });
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Chip(
                      labelPadding: const EdgeInsets.all(2.0),
                      label: Text(
                        meterReading.isNotEmpty ? meterReading : "Meter Reading",
                        style: const TextStyle(
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
                        "Select HR. Meter Reading",
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
                              dummyListData[index]["range"],
                              style: const TextStyle(fontSize: 20),
                            ),
                            onTap: () async {
                              setState(() {
                                meterReading = dummyListData[index]["range"];
                              });

                              SharedPreferences sharedPreferences =
                                  await SharedPreferences.getInstance();
                              sharedPreferences.setString(
                                  "make", widget.makeName);
                              sharedPreferences.setString(
                                  "model", widget.modelName);
                              sharedPreferences.setString(
                                  "hpRange", widget.hpRange);
                              sharedPreferences.setString(
                                  "meterReading", dummyListData[index]["range"]);
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
