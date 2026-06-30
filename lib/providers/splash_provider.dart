import 'package:bem_estar/services/splassh_service.dart';
import 'package:flutter/material.dart';

enum SplashStatus { loading, success, error }

class SplashProvider extends ChangeNotifier {
  //instância do service
  final SplashService _service = SplashService();
  SplashStatus _status = SplashStatus.loading;

  SplashStatus get status => _status;

  Future<void> startApp() async {
    _status = SplashStatus.loading;
    notifyListeners();

    // Executa a requisição de API
    final isOnline = await _service.checkStatus();

    await Future.delayed(Duration(milliseconds: 3000));

    if (isOnline) {
      _status = SplashStatus.success;
    } else {
      _status = SplashStatus.error;
    }

    notifyListeners();
  }
}
