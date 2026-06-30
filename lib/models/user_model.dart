class User {
  final String id;
  final String username;
  final String role;
  final String token;

  User({
    required this.id,
    required this.username,
    required this.role,
    required this.token,
  });

  // Fábrica para criar o o a partir da resposta do Login da API
  factory User.fromJson(Map<String, dynamic> json, String usernameDigitado) {
    return User(
      id: json['userid']?.toString() ?? '',
      username: usernameDigitado, 
      role: json['role'] ?? '',
      token: json['token'] ?? '',
    );
  }
}