
// ignore_for_file: public_member_api_docs, sort_constructors_first
class Desafio {
  final int id;
  final String activity;
  final String category;
  Desafio({
    required this.id,
    required this.activity,
    required this.category,
  });



  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'activity': activity,
      'category': category,
    };
  }

  factory Desafio.fromJson(Map<String, dynamic> json) {
    return Desafio(
      id: json['id'] as int,
      activity: json['activity'] as String,
      category: json['category'] as String,
    );
  }

}
