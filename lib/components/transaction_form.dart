import 'package:expenses/components/adaptative_button.dart';
import 'package:expenses/components/adaptative_texrfield.dart';
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
    return SingleChildScrollView(
      child: Card(
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              AdaptativeTextfield(
                controller: titleController,
                keyboardType: TextInputType.multiline,
                onSubmitted: (_) => _submitForm,
                label: 'Título',
              ),
              AdaptativeTextfield(
                controller: valueController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitForm,
                label: 'Valor (R\$)',
              ),
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
                  AdaptativeButton(
                    label: 'Nova Transação',
                    onPressed: _submitForm,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
