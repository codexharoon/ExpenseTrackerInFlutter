import 'package:expense_tracker/bar_graph/bar_graph.dart';
import 'package:expense_tracker/data/date_time.dart';
import 'package:expense_tracker/data/expense_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;

  const ExpenseSummary({super.key,required this.startOfWeek});

  @override
  Widget build(BuildContext context) {

    // calculate max amount in bar graph
    double calculateMax(
      ExpenseData value,
      String sun,
      String mon,
      String tue,
      String wed,
      String thur,
      String fri,
      String sat, 
    ){
      double max = 100;

      List<double> values = [
        value.calculateDailyExpenseSummary()[sun] ?? 0,
        value.calculateDailyExpenseSummary()[mon] ?? 0,
        value.calculateDailyExpenseSummary()[tue] ?? 0,
        value.calculateDailyExpenseSummary()[wed] ?? 0,
        value.calculateDailyExpenseSummary()[thur] ?? 0,
        value.calculateDailyExpenseSummary()[fri] ?? 0,
        value.calculateDailyExpenseSummary()[sat] ?? 0,
      ];

      values.sort();

      max = values.last * 1.1;
      return max == 0 ? 100 : max;
    }

    // calculate week total
    double calculateWeekToatal(
      ExpenseData value,
      String sun,
      String mon,
      String tue,
      String wed,
      String thur,
      String fri,
      String sat,){

        List<double> values = [
        value.calculateDailyExpenseSummary()[sun] ?? 0,
        value.calculateDailyExpenseSummary()[mon] ?? 0,
        value.calculateDailyExpenseSummary()[tue] ?? 0,
        value.calculateDailyExpenseSummary()[wed] ?? 0,
        value.calculateDailyExpenseSummary()[thur] ?? 0,
        value.calculateDailyExpenseSummary()[fri] ?? 0,
        value.calculateDailyExpenseSummary()[sat] ?? 0,
      ];

      double weekTotal = 0;
      for(int i=0; i<values.length; i++){
        weekTotal += values[i];
      }

      return weekTotal;

    }



    String sun = convertDateTimeIntoString(startOfWeek.add(const Duration(days: 0)));
    String mon = convertDateTimeIntoString(startOfWeek.add(const Duration(days: 1)));
    String tue = convertDateTimeIntoString(startOfWeek.add(const Duration(days: 2)));
    String wed = convertDateTimeIntoString(startOfWeek.add(const Duration(days: 3)));
    String thur = convertDateTimeIntoString(startOfWeek.add(const Duration(days: 4)));
    String fri = convertDateTimeIntoString(startOfWeek.add(const Duration(days: 5)));
    String sat = convertDateTimeIntoString(startOfWeek.add(const Duration(days: 6)));

    return Consumer<ExpenseData>(
      builder: (context, value, child) => Column(
        children: [
          // week total
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                const Text('Week Total: ',style: TextStyle(fontWeight: FontWeight.bold),),
                Text('\$${calculateWeekToatal(value, sun, mon, tue, wed, thur, fri, sat).toStringAsFixed(2)}'),
              ],
            ),
          ),

          //bar chart
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: SizedBox(
              height: 200,
              child: MyBarGraph(
                maxY: calculateMax(value, sun, mon, tue, wed, thur, fri, sat),
                sunAmount: value.calculateDailyExpenseSummary()[sun] ?? 0,
                monAmount: value.calculateDailyExpenseSummary()[mon] ?? 0,
                tueAmount: value.calculateDailyExpenseSummary()[tue] ?? 0,
                wedAmount: value.calculateDailyExpenseSummary()[wed] ?? 0,
                thurAmount: value.calculateDailyExpenseSummary()[thur] ?? 0,
                friAmount: value.calculateDailyExpenseSummary()[fri] ?? 0,
                satAmount: value.calculateDailyExpenseSummary()[sat] ?? 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}