import 'package:expenses_v2/Models/expenseModel.dart';
import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  Item({super.key, required this.item});

  Expense item;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white, // Set your color here
      child: Column(
        children: [
          ListTile(
            title: Text(
              item.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {},
            onLongPress: () {
              // setState(() {
              //   DatabaseHelper.instance.remove(item.id!);
              // });
            },
          ),
          Row(
            children: [
              const SizedBox(
                width: 16,
              ),
              Text(
                '\$${item.price}',
              ),
              Spacer(),
              Row(
                children: [
                  Icon(
                    categoryIcon[item.category.toLowerCase()],
                  ),
                  Text(
                    formater.format(item.date),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
