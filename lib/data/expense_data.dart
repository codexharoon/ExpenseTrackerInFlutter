import 'package:expense_tracker/data/date_time.dart';
import 'package:expense_tracker/data/hive_database.dart';
import 'package:expense_tracker/models/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseData extends ChangeNotifier{

   // list of all expense
   List<ExpenseItem> overallExpenseList = [];

   // hive instance
   final db = HiveDatabase();

   // prepare data to display
   void prepareData(){
    if(db.readData().isNotEmpty){
      overallExpenseList = db.readData();
    }
   }

   // get expense list
   List<ExpenseItem> getOverallExpenseList(){
    return overallExpenseList;
   }

   // add new expense
   void addNewExpense(ExpenseItem newExpense){
    overallExpenseList.add(newExpense);

    db.saveData(overallExpenseList);

    notifyListeners();
   }

   // delete expense
   void deleteExpense(ExpenseItem expense){
    overallExpenseList.remove(expense);

    db.saveData(overallExpenseList);

    notifyListeners();
   }


   // get weekday like 'Mon'. 'Tue' etc. from dateTime obj
   String getWeekDay(DateTime dateTime){
    switch(dateTime.weekday){
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thur';
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


   // get the date for the start of the week (sunday)
   DateTime? startOfWeekDate(){
    DateTime? startOfWeek;

    DateTime today = DateTime.now();

    for(int i=0; i<7; i++){
      if(getWeekDay(today.subtract(Duration(days: i))) == 'Sun'){
        startOfWeek = today.subtract(Duration(days: i));
      }
    }
    return startOfWeek;
   }


   //combine expense of same date, for nice total represebting each day
   Map<String,double> calculateDailyExpenseSummary(){

    Map<String,double> dailyExpenseSummary = {
      //Date (YYYYMMDD)    :   total amount for each day
    };

    for(var expense in overallExpenseList){
      String date = convertDateTimeIntoString(expense.dateTime);
      double amount = double.parse(expense.amount);

      if(dailyExpenseSummary.containsKey(date)){
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;
      }
      else{
        dailyExpenseSummary.addAll({date : amount});
      }
    }

    return dailyExpenseSummary;
   }

}