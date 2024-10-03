import 'package:hive_flutter/hive_flutter.dart';
import '../models/expense_item.dart';

class HiveDatabase {
  //reference Our box
  final _myBox = Hive.box("expense_database2");

  // write data
  void saveData(List<expenseItem> allExpense) {
    List<List<dynamic>> allExpensesFormatted = [];
    for (var expense in allExpense) {
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime,
      ];
      allExpensesFormatted.add(expenseFormatted);
    }
    _myBox.put("ALL_EXPENSES", allExpensesFormatted);
  }

  // read data
  List<expenseItem> readData() {
    List savedExpenses = _myBox.get("ALL_EXPENSES") ?? [];
    List<expenseItem> allExpenses = [];
    for (int i = 0; i < savedExpenses.length; i++) {
      String name = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      DateTime dateTime = savedExpenses[i][2];

      // create expense item
      expenseItem expense =
          expenseItem(name: name, amount: amount, dateTime: dateTime);
      allExpenses.add(expense);
    }
  return allExpenses;
  }


}
