import 'dart:convert';

class TransactionModel {
  final int id;
  final String invoiceCode;
  final int itemMasterId;
  final DateTime date;
  final String information;
  final double price;
  final int qty;
  final String itemNo;
  final String itemName;
  final String subCode;
  final String subName;

  TransactionModel({
    required this.id,
    required this.invoiceCode,
    required this.itemMasterId,
    required this.date,
    required this.information,
    required this.price,
    required this.qty,
    required this.itemNo,
    required this.itemName,
    required this.subCode,
    required this.subName,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        id: json['id'],
        invoiceCode: json['invoice_code'],
        itemMasterId: json['item_master_id'],
        date: DateTime.parse(json['date']),
        information: json['information'],
        price: double.parse(json['price']),
        qty: json['qty'],
        itemNo: json['item_no'],
        itemName: json['item_name'],
        subCode: json['sub_code'],
        subName: json['sub_name'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'invoice_code': invoiceCode,
        'item_master_id': itemMasterId,
        'date': date.toIso8601String(),
        'information': information,
        'price': price.toString(),
        'qty': qty,
        'item_no': itemNo,
        'item_name': itemName,
        'sub_code': subCode,
        'sub_name': subName,
      };
}

List<TransactionModel> transactionListFromJson(List<dynamic> jsonList) =>
    List<TransactionModel>.from(
      jsonList.map((x) => TransactionModel.fromJson(x)),
    );

// Fungsi untuk mengonversi List<Transaction> menjadi JSON
String transactionListToJson(List<TransactionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
