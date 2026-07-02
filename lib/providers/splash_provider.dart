import 'package:bem_estar/services/splash_service.dart';
import 'package:flutter/material.dart';

enum SplashStatus { loading, success, error }

class SplashProvider extends ChangeNotifier {
  //instância do service
  final SplashService _service = SplashService();
  SplashStatus _status = SplashStatus.loading;

  SplashStatus get status => _status;
  Future<void> initializeApp() async{
    _status = SplashStatus.loading;
    notifyListeners();
    
    final time = Future.delayed(Duration(seconds: 3));
    final isOnline = await _service.checkStatus();

    await time;
  _status = isOnline ? SplashStatus.success : SplashStatus.error;
  notifyListeners();

  }
}
