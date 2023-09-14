import 'package:expense_tracker/componenets/expense_summary.dart';
import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/models/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    Provider.of<ExpenseData>(context,listen: false).prepareData();
    
    super.initState();
  }

  // expense text controller
  final expenseNameController = TextEditingController();
  final expenseAmountController = TextEditingController();

  // add new expense 
  void addNewExpense(){
    showDialog(context: context,
     builder: (context) => AlertDialog(
      backgroundColor: Colors.grey[300],
      title: const Text('Add new Expense'),
      content: Column(  
        mainAxisSize: MainAxisSize.min,
        children: [
          // expense name
          TextField(
            controller: expenseNameController,
            decoration: const InputDecoration(  
              focusedBorder: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(),
              hintText: 'Expense name',
            ),
          ),
          
          const SizedBox(height: 6,),

          // amount
          TextField(
            controller: expenseAmountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(  
              focusedBorder: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(),
              hintText: 'Expense amount',
            ),
          )
        ],
      ),
      actions: [
        MaterialButton(
          onPressed: onCancel,
          child: const Text('Cancel'),
        ),
        MaterialButton(
          onPressed: onSave,
          child: const Text('Save'),
        ),
      ],
     ) 
    );
  }

  // on expense cancel
  void onCancel(){
    Navigator.of(context).pop();
    expenseAmountController.clear();
    expenseNameController.clear();
  }

  // on expense save
  void onSave(){
    if(expenseNameController.text.isEmpty || expenseAmountController.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Fill all the fields!'),));
    }
    else{
      final RegExp regex = RegExp(r'^\d+(\.\d+)?$');
      if(expenseAmountController.text.contains(regex)){
        Provider.of<ExpenseData>(context,listen: false).addNewExpense(ExpenseItem(name: expenseNameController.text, amount: expenseAmountController.text, dateTime: DateTime.now()));
        onCancel();
      }
      else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Amount should be in Nuumbers or Decimals!'),));
      }
    }
    
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder:(context, value, child) => Scaffold(
        body: ListView(
          children: [
            // weekly summary
            ExpenseSummary(startOfWeek: value.startOfWeekDate()!),

            // expense list tiltes
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: value.getOverallExpenseList().length,
              itemBuilder: (context,index) => ListTile(
                title: Text(value.getOverallExpenseList()[index].name),
                subtitle: Text('${value.getOverallExpenseList()[index].dateTime.day}/${value.getOverallExpenseList()[index].dateTime.month}/${value.getOverallExpenseList()[index].dateTime.year}'),
                trailing: Text("\$${value.getOverallExpenseList()[index].amount}"),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(  
          backgroundColor: Colors.black,
          onPressed: addNewExpense,
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      )
    );
  }
}