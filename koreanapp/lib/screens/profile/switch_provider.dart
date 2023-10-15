// import 'package:flutter/material.dart';

// class SwitchProvider extends ChangeNotifier {
//   bool _switchValue = false;

//   bool get switchValue => _switchValue;

//   void setSwitchValue(bool value) {
//     _switchValue = value;
//     print("switch value is $_switchValue");
//     notifyListeners();
//   }
// }

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SwitchProvider extends ChangeNotifier {
  bool _switchValue1 = false;
  bool _switchValue2 = false;

  bool get switchValue1 => _switchValue1;
  bool get switchValue2 => _switchValue2;

  SwitchProvider(bool initialSwitchValue1, bool initialSwitchValue2) {
    // Initialize the switch value from local storage when the provider is created.
    _loadSwitchValue1();
    _loadSwitchValue2();
  }

  void setSwitchValue1(bool value) {
    _switchValue1 = value;
    print("switch value is 1 $_switchValue1");
    // Save the switch value to local storage when it changes.
    _saveSwitchValue1(value);
    notifyListeners();
  }

  void setSwitchValue2(bool value) {
    _switchValue2 = value;
    print("switch value is 2 $_switchValue2");
    // Save the switch value to local storage when it changes.
    _saveSwitchValue2(value);
    notifyListeners();
  }

  // Load switch value from local storage
  Future<void> _loadSwitchValue1() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _switchValue1 = prefs.getBool('switchValue1') ?? false;
    notifyListeners();
  }

  Future<void> _loadSwitchValue2() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _switchValue2 = prefs.getBool('switchValue2') ?? false;
    notifyListeners();
  }

  // Save switch value to local storage
  Future<void> _saveSwitchValue1(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('switchValue1', value);
  }

  Future<void> _saveSwitchValue2(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('switchValue2', value);
  }
}
// new 2