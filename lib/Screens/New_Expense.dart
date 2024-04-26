import 'package:expenses_v2/Database/DatabaseHelper.dart';
import 'package:expenses_v2/Models/expenseModel.dart';
import 'package:flutter/material.dart';

import 'List_Item.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _openDatePicker() async {
    final DateTime now = DateTime.now();
    final DateTime firstDate = DateTime(now.year - 1);

    final pickerDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickerDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    final hightKeyBoard = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, hightKeyBoard + 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _titleController,
                    maxLength: 50,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      label: Text('Title'),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _priceController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: '\$ ',
                            label: Text('Price'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _selectedDate == null
                                  ? 'No Date Selected'
                                  : formater.format(_selectedDate!),
                            ),
                            IconButton(
                              onPressed: _openDatePicker,
                              icon: const Icon(Icons.calendar_month),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  DropdownButton(
                    value: _selectedCategory,
                    items: Category.values
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(
                              category.name.toUpperCase(),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        if (value == null) {
                          return;
                        }
                        _selectedCategory = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            child: const Text(
              'Cancel',
            ),
            onPressed: () async {
              Navigator.pop(context, true);
            },
          ),
          const SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            child: const Icon(Icons.save),
            onPressed: () async {
              final title = _titleController.text;
              final amountText = _priceController.text;
              final date = _selectedDate!;
              print(title.toString() + amountText.toString() + date.toString());
              if (title.isEmpty ||
                  _selectedDate == null ||
                  _priceController == null ||
                  _titleController == null) {
                return;
              }

              try {
                final amount = double.parse(amountText);
                final date = _selectedDate!;
                final category = _selectedCategory;

                await DatabaseHelper.instance.add(
                  Expense(
                    title: title,
                    price: amount,
                    date: date,
                    category: category.toString(),
                  ),
                );
                setState(() {
                  ListItems();
                });
                Navigator.pop(context, true);
              } catch (e) {
                print('Error: $e');
              }
            },
          ),
        ],
      ),
    );
  }
}
