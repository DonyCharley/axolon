class Detail {
  final int? id;
  final int headerId;
  final String productCode;
  final String productName;
  final double rate;
  final double quantity;
  final double total;

  Detail({ this.id, required this.headerId, required this.productCode, required this.productName, required this.rate, required this.quantity, required this.total});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'headerId': headerId,
      'productCode': productCode,
      'productName': productName,
      'rate': rate,
      'quantity': quantity,
      'total': total,
    };
  }
}
