import 'package:hive_flutter/adapters.dart';
import '../models/expense_item.dart';

class HiveDatabase{
  // refrence the hive box
  final box = Hive.box('mybox');


  // save data
  void saveData(List<ExpenseItem> expenseList){
    
    // convert the onj into list of list in order to store it in hive
    List<List<dynamic>> overallExpenseList = [];

    for(var expense in expenseList){
      List<dynamic> individualExpenseList = [
        expense.name,
        expense.amount,
        expense.dateTime
      ];

      overallExpenseList.add(individualExpenseList);
    }

    box.put('expenseList', overallExpenseList);
  }


  // read data
  List<ExpenseItem> readData(){
    var listData = box.get('expenseList');
    // expense list
    final List<ExpenseItem> allExpenseList = [];

    for(int i=0; i<listData.length; i++){
      ExpenseItem item = ExpenseItem(name: listData[i][0], amount: listData[i][1], dateTime: listData[i][2]);

      allExpenseList.add(item);
    }
    return allExpenseList;
  }


}