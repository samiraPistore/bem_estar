import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SplashStatus { loading, success, error }

class SplashProvider extends ChangeNotifier {
  SplashStatus _status = SplashStatus.loading;
  bool _usuarioJaLogado = false;

  SplashStatus get status => _status;
  bool get usuarioJaLogado => _usuarioJaLogado;

  Future<void> startApp() async {
    _status = SplashStatus.loading;
    notifyListeners();

    try {
      

      // Checa se existe um token
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token_jwt');
      final String? loginTimeStr = prefs.getString('login_time');

      if (token != null && loginTimeStr != null) {
        final loginTime = DateTime.parse(loginTimeStr);
        final diferencaEmMinutos = DateTime.now().difference(loginTime).inMinutes;

        
        if (diferencaEmMinutos < 3) {
          _usuarioJaLogado = true; // Indica que vai direto para a HomeScreen
        } else {
          // Token expirou
          await prefs.remove('token_jwt');
          await prefs.remove('login_time');
          _usuarioJaLogado = false;
        }
      } else {
        _usuarioJaLogado = false;
      }

      _status = SplashStatus.success;
    } catch (e) {
      _status = SplashStatus.error;
    }
    
    notifyListeners();
  }
}