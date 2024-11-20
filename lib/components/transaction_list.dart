import 'package:expenses/components/transaction_item.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  const TransactionList(
      {super.key, required this.transactions, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: transactions.isEmpty
          ? LayoutBuilder(
              builder: (ctx, constraints) {
                return Column(
                  children: <Widget>[
                    const SizedBox(height: 20),
                    Text(
                      'Nenhuma Transação Cadastrada',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                );
              },
            )
          : ListView(
              children: transactions.map(
                (tr) {
                  return TransactionItem(
                    key: ValueKey(tr.id),
                    tr: tr,
                    onRemove: onRemove,
                  );
                },
              ).toList(),
            ),
    );
  }
}
