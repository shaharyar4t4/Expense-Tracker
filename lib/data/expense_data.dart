//import 'dart:js_interop';

import 'package:expense_tracker/data/hive_database.dart';
import 'package:expense_tracker/datetime/date_time_helper.dart';
import 'package:flutter/material.dart';

import '../models/expense_item.dart';

class ExpenseData extends ChangeNotifier {
  // list of all Expense
  List<expenseItem> overallExpenselist = [];

  // get the All Expense List
  List<expenseItem> getAllExpenseList() {
    return overallExpenselist;

  }
  //prepare data to display
  final db =HiveDatabase();
  void prepareData(){
    if(db.readData().isNotEmpty){
      overallExpenselist = db.readData();
    }
  }


  // preform add the Expense Item
  void addNewExpense(expenseItem newExpense) {
    overallExpenselist.add(newExpense);
    notifyListeners();
    db.saveData(overallExpenselist);
  }

  // preform delete function of Expense list
  void deleteExpense(expenseItem expense) {
    overallExpenselist.remove(expense);
    notifyListeners();
    db.saveData(overallExpenselist);
  }

 //update the list
  void updateExpense(expenseItem oldExpense, expenseItem updatedExpense) {
    int index = overallExpenselist.indexOf(oldExpense);
    overallExpenselist[index] = updatedExpense;
    notifyListeners();
    db.saveData(overallExpenselist);
  }

  // get all the Days name
  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thus';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  // get the date for the start of week (Sunday)
  DateTime? startOfweekDate() {
    DateTime? startOfweek;

    DateTime today = DateTime.now();

    for (int i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'sun') {
        startOfweek = today.subtract(Duration(days: i));
      }
    }
    return startOfweek;
  }


 // handly the Daily Expense Summary like:  2023/10/02
  Map<String, double> calculateDailyExpenseSummary() {
    Map<String, double> dailyExpenseSummary = {};

    for (var expense in overallExpenselist) {
      String date = coventDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);

      if (dailyExpenseSummary.containsKey(date)) {
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;
      } else {
        dailyExpenseSummary.addAll({date: amount});
      }
    }
    return dailyExpenseSummary;
  }
}
