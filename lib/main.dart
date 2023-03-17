// ignore_for_file: library_private_types_in_public_api, avoid_print, unnecessary_type_check, unnecessary_null_comparison, prefer_interpolation_to_compose_strings, unrelated_type_equality_checks, use_build_context_synchronously

import 'dart:convert';

import 'package:breadcrumbs/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(
        makeName: '',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required String makeName});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
  Widget build(BuildContext context) {
    if (dummyListData.isNotEmpty) {
      setState(() {});
    }
    return MaterialApp.router(
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
