class Activity {
  Activity({
    required this.title,
    required this.description,
    required this.date,
  });

  final String title;
  final String description;
  final String date;

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'date': date,
    };
  }
}
