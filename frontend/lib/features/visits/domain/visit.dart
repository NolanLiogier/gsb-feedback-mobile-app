class Visit {
  const Visit({
    required this.visitId,
    required this.visitTitle,
    required this.scheduledDate,
    this.closureDate,
    this.comment,
    required this.statusName,
    required this.companyName,
  });

  final int visitId;
  final String visitTitle;
  final String scheduledDate;
  final String? closureDate;
  final String? comment;
  final String statusName;
  final String companyName;
}
