class Desafio {
  final int id;
  final String activity;
  final int totalActivities;

  Desafio({
    required this.id,
    required this.activity,
    required this.totalActivities,
  });

  factory Desafio.fromJson(Map<String, dynamic> json) {
    return Desafio(
      id: json['id'] as int,
      activity: json['activity'] as String? ?? '',
      totalActivities: json['total_activities'] as int? ?? 0,
    );
  }
}