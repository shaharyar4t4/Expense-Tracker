import 'package:expense_tracker/components/expense_summary.dart';
import 'package:expense_tracker/components/expense_tile.dart';
import 'package:expense_tracker/constant/consta.dart';
import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/models/expense_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add new Expence'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: newExpenseNameController,
              decoration: InputDecoration(
                hintText: "Expense Name",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                  borderSide: BorderSide(
                    color: tdRed,
                    width: 2,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: newExpenseAmountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Expense Amount",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                  borderSide: BorderSide(
                    color: tdRed,
                    width: 2,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
            ),
          ],
        ),
        actions: [
          MaterialButton(
            onPressed: (save),
            child: Text('Save', style: TextStyle(color: tdblack),),
          ),
          MaterialButton(
            onPressed: (cancel),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

// delete expense
  void deleteExpense(expenseItem expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
  }

  // update the expense list
  void editExpense(expenseItem oldExpense) {
    // Pre-fill the dialog with the current values
    newExpenseNameController.text = oldExpense.name;
    newExpenseAmountController.text = oldExpense.amount;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update Expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: newExpenseNameController,
              decoration: InputDecoration(
                hintText: "Expense Name",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                  borderSide: BorderSide(
                    color: tdRed,
                    width: 2,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: newExpenseAmountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Expense Amount",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                  borderSide: BorderSide(
                    color: tdRed,
                    width: 2,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
            ),
          ],
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              if (newExpenseNameController.text.isNotEmpty &&
                  newExpenseAmountController.text.isNotEmpty) {
                // Create a new expense item with updated values
                expenseItem updatedExpense = expenseItem(
                  name: newExpenseNameController.text,
                  amount: newExpenseAmountController.text,
                  dateTime: oldExpense.dateTime, // Keep the original date
                );

                // Call the update method in ExpenseData
                Provider.of<ExpenseData>(context, listen: false)
                    .updateExpense(oldExpense, updatedExpense);

                Navigator.pop(context);
                clean(); // Clear the text fields
              }
            },
            child: Text('Update', style: TextStyle(color: tdblack),),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
              clean();
            },
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void save() {
    if (newExpenseNameController.text.isNotEmpty &&
        newExpenseAmountController.text.isNotEmpty) {
      expenseItem newExpense = expenseItem(
        name: newExpenseNameController.text,
        amount: newExpenseAmountController.text,
        dateTime: DateTime.now(),
      );

      Provider.of<ExpenseData>(context, listen: false)
          .addNewExpense(newExpense);
    }
    Navigator.pop(context);
    clean();
  }

  void cancel() {
    Navigator.pop(context);
    clean();
  }

  void clean() {
    newExpenseAmountController.clear();
    newExpenseNameController.clear();
  }

  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: tdBGcolor,
        floatingActionButton: FloatingActionButton(
          onPressed: addNewExpense,
          backgroundColor: tdRed,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: ListView(
          children: [
            //weekly Summary, using a default value if startOfweekDate is null
            ExpenseSummary(
                startOfWeek: value.startOfweekDate() ?? DateTime.now()),
            //expense List
            SizedBox(
              height: 20,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: value.getAllExpenseList().length,
              itemBuilder: (context, index) => ExpenseTile(
                name: value.getAllExpenseList()[index].name,
                amount: value.getAllExpenseList()[index].amount,
                dateTime: value.getAllExpenseList()[index].dateTime,
                deleteTapped: (p0) =>
                    deleteExpense(value.getAllExpenseList()[index]),
                editTapped: (p0) =>
                    editExpense(value.getAllExpenseList()[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
