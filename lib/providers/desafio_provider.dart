import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bem_estar/services/desafios_service.dart';

class DesafiosProvider extends ChangeNotifier {
  final DesafiosService _service = DesafiosService();

  int _desafioAtualId = 1;
  String? _textoDesafioExibido;
  bool _isLoading = false;

  int get desafioAtualId => _desafioAtualId;
  String? get textoDesafioExibido => _textoDesafioExibido;
  bool get isLoading => _isLoading;

  /// Inicializa o ID salvo localmente
  Future<void> carregarProgresso() async {
    final prefs = await SharedPreferences.getInstance();
    _desafioAtualId = prefs.getInt('desafio_atual_id') ?? 1;
    notifyListeners();
  }

  /// Busca o desafio na API
  Future<bool> buscarDesafio(String token) async {
    _isLoading = true;
    notifyListeners(); 
    

    final desafio = await _service.getDesafios(_desafioAtualId, token);

    _isLoading = false;
    if (desafio != null) {
      _textoDesafioExibido = desafio.activity;
      notifyListeners();
      return true; // Sucesso (HTTP 200)
    }

    notifyListeners();
    return false; // Falha (HTTP != 200), indica que deve deslogar
  }

  /// Oculta o texto ao concluir
  void concluirDesafio() {
    _textoDesafioExibido = null;
    notifyListeners();
  }

  /// Avança o contador do desafio
  Future<void> proximoDesafio() async {
    if (_desafioAtualId < 5) {
      _desafioAtualId++;
      _textoDesafioExibido = null; // Oculta o texto anterior conforme a regra
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('desafio_atual_id', _desafioAtualId);
      notifyListeners();
    }
  }
}