import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  const TransactionForm(this.onSubmit, {super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();
  final valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final tittle = titleController.text;
    final valueText = valueController.text.replaceAll(',', '.');
    final value = double.tryParse(valueText) ?? 0.0;

    if (tittle.isEmpty || value <= 0) {
      return;
    }

    widget.onSubmit(tittle, value, _selectedDate);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickeadDate) {
      if (pickeadDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickeadDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
                controller: titleController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.multiline,
                onSubmitted: (_) => _submitForm,
                decoration: const InputDecoration(labelText: 'Título')),
            TextField(
                controller: valueController,
                textInputAction: TextInputAction.done,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitForm,
                decoration: const InputDecoration(labelText: 'Valor (R\$)')),
            SizedBox(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'Data Selecionada: ${DateFormat('dd/MM/y').format(_selectedDate)}',
                      style: const TextStyle(fontWeight: FontWeight.normal),
                    ),
                  ),
                  TextButton(
                    onPressed: _showDatePicker,
                    child: const Text(
                      'Selecionar Data',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: const Text('Cancelar'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Nova Transação'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
