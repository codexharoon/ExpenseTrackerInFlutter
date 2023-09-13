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

    String sun = convertDateTimeIntoString(startOfWeek.add(const Duration(days: 0)));
    String mon = convertDateTimeIntoString(startOfWeek.add(const Duration(days: 1)));
    String tue = convertDateTimeIntoString(startOfWeek.add(const Duration(days: 2)));
    String wed = convertDateTimeIntoString(startOfWeek.add(const Duration(days: 3)));
    String thur = convertDateTimeIntoString(startOfWeek.add(const Duration(days: 4)));
    String fri = convertDateTimeIntoString(startOfWeek.add(const Duration(days: 5)));
    String sat = convertDateTimeIntoString(startOfWeek.add(const Duration(days: 6)));

    return Consumer<ExpenseData>(
      builder: (context, value, child) => Padding(
        padding: const EdgeInsets.only(top: 20,bottom: 20),
        child: SizedBox(
          height: 200,
          child: MyBarGraph(
            maxY: 100,
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
    );
  }
}