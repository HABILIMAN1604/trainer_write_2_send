class Trainee {
  final String employeeId;
  final String name;
  final String shift;

  Trainee({required this.employeeId, required this.name, required this.shift});

  factory Trainee.fromJson(Map<String, dynamic> json) {
    return Trainee(
      employeeId: json['employeeId'],
      name: json['name'],
      shift: json['shift'],
    );
  }
}

class TrainingReport {
  final String dateJoin;
  final String trainingDay;
  final String location;
  final List<Trainee> trainees;

  TrainingReport({
    required this.dateJoin,
    required this.trainingDay,
    required this.location,
    required this.trainees,
  });

  factory TrainingReport.fromJson(Map<String, dynamic> json) {
    return TrainingReport(
      dateJoin: json['dateJoin'] ?? '',
      trainingDay: json['trainingDay'] ?? '',
      location: json['location'] ?? '',
      trainees: (json['trainees'] as List)
          .map((i) => Trainee.fromJson(i))
          .toList(),
    );
  }
}