class Incidencia {
  int? id;
  String title;
  String description;
  String date;
  String photoPath;
  String audioPath;

  Incidencia({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.photoPath,
    required this.audioPath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'photoPath': photoPath,
      'audioPath': audioPath,
    };
  }

  factory Incidencia.fromMap(Map<String, dynamic> map) {
    return Incidencia(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      date: map['date'],
      photoPath: map['photoPath'],
      audioPath: map['audioPath'],
    );
  }
}
