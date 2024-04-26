import 'package:expenses_v2/Screens/List_Item.dart';
import 'package:expenses_v2/Screens/New_Expense.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  void _openAddExpenseOverlay() async {
    final result = await showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => const NewExpense(),
    );

    if (result == true) {
      setState(() {
        _openListItem();
      });
    }
  }

  Widget _openListItem() {
    return const ListItems();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome my app'),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  _openAddExpenseOverlay();
                  _openListItem();
                });
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: _openListItem(),
        floatingActionButton: FloatingActionButton(child: const Icon(Icons.refresh),onPressed: (){
          setState(() {
            _openListItem();
          });
        },),
      ),
    );
  }
}
