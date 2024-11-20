import 'dart:math';

import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  final Transaction tr;
  final void Function(String) onRemove;

  const TransactionItem({
    Key? key,
    required this.tr,
    required this.onRemove,
  }) : super(key: key);

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  static const colors = [
    Colors.red,
    Colors.blue,
    Colors.purple,
    Colors.yellow,
    Colors.black,
    Colors.green,
  ];

  late Color _backgroundColor;
  @override
  void initState() {
    super.initState();

    int i = Random().nextInt(6);
    _backgroundColor = colors[i];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _backgroundColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text('R\$${widget.tr.value.toStringAsFixed(2)}'),
            ),
          ),
        ),
        title: Text(
          widget.tr.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(DateFormat('d MMM y').format(widget.tr.date)),
        trailing: MediaQuery.of(context).size.width > 500
            ? TextButton.icon(
                onPressed: () => widget.onRemove(widget.tr.id),
                label: Text(
                  'Excluir',
                  selectionColor: Theme.of(context).colorScheme.secondary,
                ),
                icon: const Icon(Icons.delete),
                style: ButtonStyle(
                  iconColor: WidgetStateProperty.all(
                      Theme.of(context).colorScheme.error),
                ),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).colorScheme.error,
                onPressed: () => widget.onRemove(widget.tr.id),
              ),
      ),
    );
  }
}
