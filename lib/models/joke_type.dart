class JokeType {
  final String name;

  JokeType({required this.name});

  factory JokeType.fromJson(String type) {
    return JokeType(name: type);
  }
}