import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
 static const String _baseUrl = 'https://workspace.dinizeotecnologia.com.br/seletiva_pr_a2/login';

  
  Future<Map<String, dynamic>?> login(String username, String password) async {
    try {
      final response = await http.post(Uri.parse(_baseUrl),
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
