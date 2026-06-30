import 'package:http/http.dart' as http;

class SplashService {
  static const String _baseUrl =
      'https://workspace.dinizeotecnologia.com.br/seletiva_pr_a2/status';

  Future<bool> checkStatus() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
