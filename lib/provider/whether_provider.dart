import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wheather_app/helper/apihelper.dart';
import 'package:wheather_app/modal/whethermodel.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import '../modal/searchmodel.dart';

class WhetherProvider extends ChangeNotifier {
  Weather? weather;
  DateTime dateTime = DateTime.now();
  String name = "surat";
  String? isClicked;
  TextEditingController textEditingController =
      TextEditingController(text: 'surat');
  List<Location> list = [];
  Logger logger = Logger();

  WhetherProvider() {
    // getData();
    fetchData();
  }

  Future<void> fetchData() async {
    ApiHelper apiHelper = ApiHelper();
    String? jsonData = await apiHelper.getData(isClicked ?? name);
    if (jsonData != null) {
      Map dataList = jsonDecode(jsonData);
      weather = Weather.getData(dataList);
      //print(jsonData);
      logger.i(jsonData);
      notifyListeners();
    }
  }

  // Future<void> searchapi() async {
  //   ApiHelper apiHelper = ApiHelper();
  //   String? jsonData = await apiHelper.getsearchdata(name);
  //   if (jsonData != null) {
  //     List dataList = jsonDecode(jsonData);
  //     list = dataList.map((e) => Location.fromJson(e)).toList();
  //     this.name = name;
  //     notifyListeners();
  //     // print(list);
  //     logger.i(list);
  //   }
  // }
  Future<void> searchApi(String name) async {
    ApiHelper apiHelper = ApiHelper();
    String? jsonData = await apiHelper.getsearchdata(name);
    if (jsonData != null) {
      List dataList = jsonDecode(jsonData);
      list = dataList.map((e) => Location.fromJson(e)).toList();
      this.name = name;
      notifyListeners();
      print(list);
    }
  }

  void changecontroller(String value) {
    textEditingController.text = value;
    notifyListeners();
  }

  Future<void> setData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('is clicked', '');
    notifyListeners();
  }

  Future<void> getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    isClicked = preferences.getString('is clicked');
    notifyListeners();
  }
}
