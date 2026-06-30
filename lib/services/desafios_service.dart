import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bem_estar/models/desafio_model.dart'; // Importe o seu modelo aqui

class DesafiosService {
  static const String _baseUrl = 'https://workspace.dinizeotecnologia.com.br/seletiva_pr_a2/desafios';

  /// Busca o desafio enviando o ID dinâmico e o Token Bearer
  Future<Desafio?> getDesafios(int idDesafio, String token) async {
    try {
      // 1. Passa o ID correto na URL e não a palavra 'id'
      final response = await http.get(
        Uri.parse('$_baseUrl/$idDesafio'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // 2. Envia o token exigido pela API
        },
      ).timeout(const Duration(seconds: 10));

      // 3. Se retornar sucesso, decodifica o JSON para o modelo Desafio
      if (response.statusCode == 200) {
        final Map<String, dynamic> dadosJson = jsonDecode(response.body);
        return Desafio.fromJson(dadosJson);
      }
      
      return null; // Código diferente de 200 (ex: 401 não autorizado) retorna null
    } catch (_) {
      return null; // Qualquer falha de rede/timeout cai aqui
    }
  }
}