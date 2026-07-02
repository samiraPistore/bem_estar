import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bem_estar/services/desafios_service.dart';

class DesafiosProvider extends ChangeNotifier {
  final DesafiosService _service = DesafiosService();

  int _desafioAtualId = 1;
  String? _textoDesafioExibido;
  bool _isLoading = false;
  final int _totalDesafiosDoSistema = 5; 
  int get desafioAtualId => _desafioAtualId;
  String? get textoDesafioExibido => _textoDesafioExibido;
  bool get isLoading => _isLoading;

  Future<String> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userid') ?? 'default';
  }
  

  Future<bool> buscarDesafio(String token) async {
  _isLoading = true;
  notifyListeners(); 

  final desafio = await _service.getDesafios(_desafioAtualId, token);

  _isLoading = false;
  if (desafio != null) {
    _textoDesafioExibido = desafio.activity;
    notifyListeners();
    return true; 
  }

  notifyListeners();
  return false; 
}

  /// Oculta o texto ao concluir e salva no histórico local do usuário
  Future<void> concluirDesafio() async {
    if (_textoDesafioExibido == null) return;
    
    final prefs = await SharedPreferences.getInstance();
    String userId = await _getUserId();
    
    List<String> concluidos = prefs.getStringList('user_${userId}_concluidos') ?? [];
    if (!concluidos.contains(_desafioAtualId.toString())) {
      concluidos.add(_desafioAtualId.toString());
      await prefs.setStringList('user_${userId}_concluidos', concluidos);
    }

    _textoDesafioExibido = null; 
    notifyListeners();
  }

  /// Avança o contador do desafio isolado por usuário
  Future<void> proximoDesafio() async {
    if (_desafioAtualId < _totalDesafiosDoSistema) {
      _desafioAtualId++;
      _textoDesafioExibido =  ''; 

      final prefs = await SharedPreferences.getInstance();
      
      String userId = await _getUserId();
      
      await prefs.setInt('user_${userId}_desafio_atual', _desafioAtualId);
      notifyListeners();
    }
  }
}

