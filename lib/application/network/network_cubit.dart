import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum NetworkStatus { online, offline }

class NetworkCubit extends Cubit<NetworkStatus> {
  final Connectivity _connectivity;
  late final StreamSubscription<List<ConnectivityResult>> _subscription;
  bool _hasEmittedOnce = false;

  NetworkCubit(this._connectivity) : super(NetworkStatus.online) {
    _init();
  }

  Future<void> _init() async {
    final results = await _connectivity.checkConnectivity();
    final initialStatus = _mapResultsToStatus(results);
    emit(initialStatus);
    _hasEmittedOnce = true;

    _subscription = _connectivity.onConnectivityChanged.listen((results) {
      final newStatus = _mapResultsToStatus(results);
      if (_hasEmittedOnce && newStatus != state) {
        emit(newStatus);
      }
    });
  }

  NetworkStatus _mapResultsToStatus(List<ConnectivityResult> results) {
    if (results.contains(ConnectivityResult.mobile) ||
        results.contains(ConnectivityResult.wifi) ||
        results.contains(ConnectivityResult.ethernet)) {
      return NetworkStatus.online;
    } else {
      return NetworkStatus.offline;
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
