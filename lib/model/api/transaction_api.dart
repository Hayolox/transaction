import 'package:flutter_application_1/constan/base_url.dart';
import 'package:flutter_application_1/model/transaction_list_response_model.dart';

class TransactionApi {
  final BaseUrl _baseUrl = BaseUrl();

  Future<List<TransactionModel>> getTransactionList() async {
    final response = await _baseUrl.dio.get(
      'transactions',
    );

    return transactionListFromJson(response.data);
  }
}
