import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionChecker {
  Future<bool> hasConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }
}
