import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/model/api/transaction_api.dart';
import 'package:flutter_application_1/model/transaction_list_response_model.dart';

part 'transaction_cubit_state.dart';

class TransactionCubit extends Cubit<TransactionCubitState> {
  TransactionCubit() : super(TransactionCubitInitial());

  void getTransactionList() async {
    try {
      var resultTransactionList = await TransactionApi().getTransactionList();

      emit(TransactionGetListState(responseModel: resultTransactionList));
    } catch (e) {
      emit(
        TransactionGetErrorListState(
          error: e.toString(),
        ),
      );
    }
  }
}
