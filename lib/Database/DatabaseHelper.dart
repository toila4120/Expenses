import 'dart:io';
import 'package:expenses_v2/Models/expenseModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'expenses.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE expenses (
      id INTEGER PRIMARY KEY,
      title TEXT NOT NULL,
      price REAL NOT NULL,
      date TEXT NOT NULL,
      category TEXT NOT NULL
    )
  ''');
  }

  Future<List<Expense>> getExpense() async {
    Database db = await instance.database;
    var expenses = await db.query('expenses', orderBy: 'title');
    List<Expense> expenseList = expenses.isNotEmpty
        ? expenses.map((c) => Expense.fromMap(c)).toList()
        : [];
    return expenseList;
  }

  Future<int> add(Expense expense) async {
    Database db = await instance.database;
    int id = await db.insert('expenses', expense.toMap());
    return id;
  }

  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete('expenses', where: 'id = ?', whereArgs: [id]);
  }
}
