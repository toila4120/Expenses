import 'package:expenses_v2/Database/DatabaseHelper.dart';
import 'package:expenses_v2/Models/expenseModel.dart';
import 'package:flutter/material.dart';

class ListItems extends StatefulWidget {
  const ListItems({super.key});

  @override
  State<ListItems> createState() => _ListItemsState();
}

class _ListItemsState extends State<ListItems> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<Expense>>(
        future: DatabaseHelper.instance.getExpense(),
        builder: (BuildContext context, AsyncSnapshot<List<Expense>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: Text('Loading...'));
          }
          return snapshot.data!.isEmpty
              ? const Center(child: Text('No Expenses in List.'))
              : ListView(
                  children: snapshot.data!.map((expense) {
                    return Card(
                      color: Colors.white, // Set your color here
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              expense.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () {},
                            onLongPress: () {
                              setState(() {
                                DatabaseHelper.instance.remove(expense.id!);
                              });
                            },
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 16,
                              ),
                              Text(
                                '\$${expense.price}',
                              ),
                              Spacer(),
                              Row(
                                children: [
                                  Icon(
                                    categoryIcon[
                                        expense.category.toLowerCase()],
                                  ),
                                  Text(
                                    formater.format(expense.date),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  }).toList(),
                );
        },
      ),
    );
  }
}
