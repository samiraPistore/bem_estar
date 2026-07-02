import 'dart:convert';
import 'package:bem_estar/models/desafio_model.dart';
import 'package:http/http.dart' as http;


class DesafiosService {
  static const String _baseUrl = 'https://workspace.dinizeotecnologia.com.br/seletiva_pr_a2/desafio';

  Future<Desafio?> getDesafios(int id, String token) async {
  try {
    final response = await http.get(
      Uri.parse('$_baseUrl/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', 
      },
    );


    print('Status Code da API: ${response.statusCode}');
    print('Corpo da Resposta da API: ${response.body}');
    print('User token: ${token}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> dadosJson = jsonDecode(response.body);
      return Desafio.fromJson(dadosJson);
    }
    return null; 
  } catch (error) {
    print('Erro na requisição: $error');
    return null; 
  }
}
}



 

