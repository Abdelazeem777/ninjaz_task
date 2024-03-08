import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rxdart/rxdart.dart';

import '../../api_end_point.dart';

class ConnectionChecker {
  static final _singleton = ConnectionChecker._internal();
  ConnectionChecker._internal();
  factory ConnectionChecker() => _singleton;

  bool? _hasConnection;
  bool get hasConnection => _hasConnection ?? false;

  final _connectionChangeController =
      BehaviorSubject<ConnectionCheckerResult>();
  final _connectivity = Connectivity();

  Stream<ConnectionCheckerResult> get connectionStream =>
      _connectionChangeController.stream;

  Future<void> initialize() async {
    _connectivity.onConnectivityChanged.listen(_checkConnection);
    _checkConnection(await _connectivity.checkConnectivity());
  }

  Future<void> _checkConnection(ConnectivityResult result) async {
    final previousConnection = _hasConnection;

    try {
      final lookUpResult = await InternetAddress.lookup(
          ApiEndPoint.BASE_URL.replaceFirst('https://', ''));
      _hasConnection =
          lookUpResult.isNotEmpty && lookUpResult[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      _hasConnection = false;
    }

    if (previousConnection != _hasConnection)
      _connectionChangeController.add(ConnectionCheckerResult(
        newState: _hasConnection!,
        oldState: previousConnection ?? false,
      ));
  }

  Future<void> dispose() => _connectionChangeController.close();
}

class ConnectionCheckerResult {
  final bool oldState;
  final bool newState;

  const ConnectionCheckerResult({
    required this.oldState,
    required this.newState,
  });
}
