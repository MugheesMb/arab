class Doctor {
  final String name;
  final String speciality;
  final String? detail;
  final String qualifications;
  final String imageUrl;

  Doctor({
    required this.name,
    this.detail,
    required this.speciality,
    required this.qualifications,
    required this.imageUrl,
  });
}
