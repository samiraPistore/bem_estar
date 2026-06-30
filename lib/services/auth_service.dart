import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String _url =
      'https://workspace.dinizeotecnologia.com.br/seletiva_pr_a2/login';

  /// Faz o POST de login e retorna o Map com os dados se der certo, ou null se falhar.
  Future<Map<String, dynamic>?> login(
    String username,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(_url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      }
      return null;
    } catch (_) {
      return null;
    }
  }
}
