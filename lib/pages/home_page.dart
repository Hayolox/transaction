import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/transaction_cubit_cubit.dart';
import 'package:flutter_application_1/utility/utility.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransactionCubit()..getTransactionList(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Data Pembelian"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<TransactionCubit, TransactionCubitState>(
            builder: (context, state) {
              if (state is TransactionGetListState) {
                int rowIndex = 1; // Nomor urutan

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(
                        label: Text('No'),
                      ),
                      DataColumn(
                        label: Text(
                          'Invoice No',
                        ),
                      ),
                      DataColumn(
                        label: Text('Tanggal'),
                      ),
                      DataColumn(
                        label: Text('Kode Product'),
                      ),
                      DataColumn(
                        label: Text('Nama Product'),
                      ),
                      DataColumn(
                        label: Text('Kode sub Product'),
                      ),
                      DataColumn(
                        label: Text('Qty'),
                      ),
                      DataColumn(
                        label: Text('Amount'),
                      ),
                    ],
                    rows: state.responseModel.map(
                      (transaction) {
                        final formattedDate =
                            Utility.formatDate(transaction.date);
                        final formattedPrice =
                            Utility.formatDecimal(transaction.price);

                        return DataRow(
                          cells: [
                            DataCell(
                              SizedBox(
                                width: double.infinity,
                                child: Center(
                                  child: Text(
                                    (rowIndex++).toString(),
                                  ),
                                ),
                              ), // Nomor urutan
                            ),
                            DataCell(
                              SizedBox(
                                width: double.infinity,
                                child: Center(
                                  child: Text(formattedDate),
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: double.infinity,
                                child: Center(
                                  child: Text(transaction.invoiceCode),
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: double.infinity,
                                child: Center(
                                  child: Text(transaction.itemNo),
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: double.infinity,
                                child: Center(
                                  child: Text(transaction.itemName),
                                ),
                              ),
                            ),
                            DataCell(SizedBox(
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  transaction.subCode,
                                ),
                              ),
                            )),
                            DataCell(
                              SizedBox(
                                width: double.infinity,
                                child: Center(
                                  child: Text(
                                    transaction.qty.toString(),
                                  ),
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: double.infinity,
                                child: Center(
                                  child: Text(formattedPrice),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ).toList(),
                  ),
                );
              } else if (state is TransactionGetErrorListState) {
                return Center(
                  child: Text('Error: ${state.error}'),
                );
              } else {
                // State lainnya atau saat sedang memuat data
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
