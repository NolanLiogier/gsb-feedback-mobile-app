class VisitDetails {
  const VisitDetails({
    required this.visitId,
    required this.visitTitle,
    required this.scheduledDate,
    this.closureDate,
    this.creationDate,
    this.comment,
    required this.statusId,
    required this.statusName,
    this.rate,
    required this.companyName,
    required this.companyAddress,
    required this.clientName,
    required this.clientPhone,
    required this.clientFunction,
  });

  final int visitId;
  final String visitTitle;
  final String scheduledDate;
  final String? closureDate;
  final String? creationDate;
  final String? comment;
  final int statusId;
  final String statusName;
  final int? rate;
  final String companyName;
  final String companyAddress;
  final String clientName;
  final String clientPhone;
  final String clientFunction;
}
