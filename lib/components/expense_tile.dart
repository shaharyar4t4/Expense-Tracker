import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpenseTile extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime dateTime;
  void Function(BuildContext)? deleteTapped;
  void Function(BuildContext)? editTapped;

   ExpenseTile({
    super.key,
    required this.name,
    required this.amount,
    required this.dateTime,
    required this.deleteTapped,
     required this.editTapped,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(onPressed: deleteTapped,
          icon: Icons.delete,
            backgroundColor: Colors.red,
            borderRadius: BorderRadius.circular(6),
          ),
          SlidableAction(onPressed: editTapped,
            icon: Icons.update,
            backgroundColor: Colors.green,
            borderRadius: BorderRadius.circular(6),
          )
        ],
      ),
      child: ListTile(
        title: Text(name),
        subtitle: Text(dateTime.day.toString() +
            '/' +
            dateTime.month.toString() +
            '/' +
            dateTime.year.toString()),
        trailing: Text('Rs: ${amount}', style: TextStyle(fontSize: 15,),),
      ),
    );
  }
}
