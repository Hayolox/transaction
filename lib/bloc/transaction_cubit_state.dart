part of 'transaction_cubit_cubit.dart';

sealed class TransactionCubitState extends Equatable {
  const TransactionCubitState();

  @override
  List<Object> get props => [];
}

final class TransactionCubitInitial extends TransactionCubitState {}

class TransactionGetListState extends TransactionCubitState {
  final List<TransactionModel> responseModel;

  const TransactionGetListState({required this.responseModel});

  @override
  List<Object> get props => [responseModel];
}

class TransactionGetErrorListState extends TransactionCubitState {
  final String error;

  const TransactionGetErrorListState({required this.error});

  @override
  List<Object> get props => [error];
}
