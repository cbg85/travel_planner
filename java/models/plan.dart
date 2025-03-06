class Plan {
  String id;
  String name;
  String description;
  DateTime date;
  bool isCompleted;

  Plan({
    required this.id,
    required this.name,
    required this.description,
    required this.date,
    this.isCompleted = false,
  });

  // Method to toggle completion status
  void toggleCompleted() {
    isCompleted = !isCompleted;
  }

  // Convert Plan object to a Map (for storage in SQLite or JSON)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'date': date.toIso8601String(),
      'isCompleted': isCompleted ? 1 : 0, // Store as an integer (0 or 1)
    };
  }

  // Create a Plan object from a Map (useful for loading from a database)
  factory Plan.fromMap(Map<String, dynamic> map) {
    return Plan(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      date: DateTime.parse(map['date']),
      isCompleted: map['isCompleted'] == 1,
    );
  }
}
