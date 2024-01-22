import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/transaction_cubit_cubit.dart';
import 'package:flutter_application_1/model/item_master_model.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuyItemPage extends StatefulWidget {
  const BuyItemPage({super.key, required this.itemMaterModel});

  final ItemMaterModel itemMaterModel;

  @override
  State<BuyItemPage> createState() => _BuyItemPageState();
}

class _BuyItemPageState extends State<BuyItemPage> {
  TextEditingController qTYController = TextEditingController();
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: BlocProvider(
          create: (context) => TransactionCubit(),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
            child: Column(
              children: [
                const SizedBox(
                  height: 18,
                ),
                Row(
                  children: [
                    const Expanded(
                      child: Text("Kode Product"),
                    ),
                    Text(widget.itemMaterModel.itemNo ?? '')
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    const Expanded(
                      child: Text("Nama Product"),
                    ),
                    Text(widget.itemMaterModel.itemName ?? '')
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    const Expanded(
                      child: Text("Kode Sub Product"),
                    ),
                    Text(widget.itemMaterModel.subItem?.subCode ?? '')
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    const Expanded(
                      child: Text("Nama Sub Product"),
                    ),
                    Text(widget.itemMaterModel.subItem?.subName ?? '')
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    const Text("Jumlah"),
                    const SizedBox(
                      width: 120,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: qTYController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Qty',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    const Expanded(
                      child: Text("Tanggal"),
                    ),
                    TextButton(
                      onPressed: () {
                        _selectDate(context);
                      },
                      child: Text(selectedDate != null
                          ? selectedDate!.toLocal().toString().split(' ')[0]
                          : "Pilih Tanggal"),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                BlocListener<TransactionCubit, TransactionCubitState>(
                  listener: (context, state) {
                    if (state is TransactionPostingState) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    }

                    if (state is TransactionPostingErorState) {
                      return _showSnackbar(context, state.error);
                    }
                  },
                  child: BlocBuilder<TransactionCubit, TransactionCubitState>(
                    builder: (context, state) {
                      if (state is TransactionLoadingState) {
                        return ElevatedButton(
                          onPressed: () {},
                          child: const Text('Loading...'),
                        );
                      }

                      if (state is TransactionPostingErorState) {}
                      return ElevatedButton(
                        onPressed: qTYController.text.isNotEmpty &&
                                selectedDate != null
                            ? () {
                                context
                                    .read<TransactionCubit>()
                                    .postTransaction(
                                      itemId:
                                          widget.itemMaterModel.id.toString(),
                                      qty: qTYController.text,
                                      date: selectedDate.toString(),
                                    );
                              }
                            : null,
                        child: const Text('Input'),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSnackbar(BuildContext context, String errorMessage) {
    final snackbar = SnackBar(
      content: Text(errorMessage),
      duration: const Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}
