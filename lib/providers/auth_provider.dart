import 'package:bem_estar/models/user_model.dart';
import 'package:bem_estar/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // IMPORTANTE

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _usuarioLogado;
  bool _isLoading = false;

  User? get usuarioLogado => _usuarioLogado;
  bool get isLoading => _isLoading;

  Future<bool> login(String username, String password) async {
    _isLoading = true;
    notifyListeners(); 

    final response = await _authService.login(username, password);

    if (response != null) {
      _usuarioLogado = User.fromJson(response, username);

      
      final prefs = await SharedPreferences.getInstance();
      if (response['token'] != null) {
        await prefs.setString('token_jwt', response['token']);
        await prefs.setString('login_time', DateTime.now().toIso8601String());
      }

      _isLoading = false;
      notifyListeners();
      return true;
    }

    _isLoading = false;
    notifyListeners();
    return false; 
  }
}