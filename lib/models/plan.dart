class Plan {
  final String id;
  final String name;
  final String description;
  final DateTime date;
  bool isCompleted;

  Plan({
    required this.id,
    required this.name,
    required this.description,
    required this.date,
    this.isCompleted = false,
  });

  void toggleCompleted() {
    isCompleted = !isCompleted;
  }
}
