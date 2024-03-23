class Header {
  final int? id;
  final String customer;
  final String note;
  final DateTime date;
  final double? grandTotal;

  Header({ this.id, required this.customer, required this.note, required this.date, this.grandTotal});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customer': customer,
      'note': note,
      'date': date.toIso8601String(),
      'grandTotal': grandTotal??'0',
    };
  }
}