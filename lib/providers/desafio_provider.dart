import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bem_estar/services/desafios_service.dart';

class DesafiosProvider extends ChangeNotifier {
  final DesafiosService _service = DesafiosService();

  int _desafioAtualId = 1;
  String? _textoDesafioExibido;
  bool _isLoading = false;
  
  // CORRIGIDO (Sintaxe com underscores): Limite padrão inicial, mas será atualizado pela API
  int _totalDesafiosDoSistema = 30; 

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
      
      // EXTRA: Se a API mandar o total_activities por lá, atualizamos dinamicamente
      // (Supondo que você mapeie essa propriedade dentro do seu Desafio model)
      // _totalDesafiosDoSistema = desafio.totalActivities; 

      notifyListeners();
      return true; 
    }

    notifyListeners();
    return false; 
  }

  /// Oculta o texto ao concluir (Marcado como concluído e oculto da interface)
  void concluirDesafio() {
    _textoDesafioExibido = null;
    notifyListeners();
  }

  /// Avança o contador do desafio
  Future<void> proximoDesafio() async {
    // Regra do enunciado: "somente após clicar no botão de 'Ver desafio do dia' esse novo texto deve ser mostrado."
    // Portanto, ao clicar no botão "Próximo desafio", incrementamos o número e limpamos a tela.
    if (_desafioAtualId < _totalDesafiosDoSistema) {
      _desafioAtualId++;
      _textoDesafioExibido = null; // Oculta o texto anterior para forçar clicar em "Ver desafio" de novo
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('desafio_atual_id', _desafioAtualId);
      notifyListeners();
    }
  }
}