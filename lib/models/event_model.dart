class EventModel {
  final String title;
  final String description;
  final String imagePath;
  final DateTime date;
  final String type; // ✅ الحقل الجديد
  bool isSaved;

  EventModel({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.date,
    required this.type, // ✅ لازم تمرره من كل مكان
    this.isSaved = false,
  });
}
