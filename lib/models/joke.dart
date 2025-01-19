// models/joke.dart
class Joke {
  final int id;
  final String type;
  final String setup;
  final String punchline;

  Joke({
    required this.id,
    required this.type,
    required this.setup,
    required this.punchline,
  });

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      id: json['id'],
      type: json['type'],
      setup: json['setup'],
      punchline: json['punchline'],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Joke && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}