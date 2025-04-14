import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/expenses_model.dart';
import '../providers/expenses_provider.dart';
import '../Utilities/widgets.dart';
import '../Utilities/my_drawer.dart';

class ExpenseEntry extends StatefulWidget {
  final Expense? expenseToEdit; // nullable svariable for editing expense
  const ExpenseEntry({super.key, this.expenseToEdit}); // takes in a key and an expense to edit (if any)

  @override
  State<ExpenseEntry> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ExpenseEntry> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String selectedCategory = category[0]; // defualt is bills
  TextEditingController amountController = TextEditingController();
  bool isPaid = false;  // payment status

  // available expense categories
  static final List<String> category = [
    "Bills", "Transportation", "Food",
    "Utilities", "Health", "Entertainment", "Miscellaneous",
  ];

  // lifecycle methods
  @override
  void initState() {
    super.initState();
    selectedCategory = category[0];
    // pre fill form if editing existing expense
    if (widget.expenseToEdit != null) {
      nameController.text = widget.expenseToEdit!.name;
      descriptionController.text = widget.expenseToEdit!.description;
      amountController.text = widget.expenseToEdit!.amount.toString();
      selectedCategory = widget.expenseToEdit!.category;
      isPaid = widget.expenseToEdit!.paid;
    }
  }

  @override
  void dispose() {
    // stop listening
    nameController.dispose();
    descriptionController.dispose();
    amountController.dispose();
    super.dispose();
  }

  // upload data to Firebase
  Future<void> submitExpenseToFirebase() async {
    if (!formKey.currentState!.validate()) return;

    final provider = Provider.of<ExpenseListProvider>(context, listen: false);

    if (widget.expenseToEdit == null) {
      await provider.addExpense(  // add new expense
        Expense(
            name: nameController.text.trim(),
            description: descriptionController.text.trim(),
            category: selectedCategory,
            amount: double.parse(amountController.text),
            paid: isPaid,
            ),
      );
    } else {
      // editing exiting expense
      await provider.editExpense(
        widget.expenseToEdit!,
        nameController.text.trim(),
        descriptionController.text.trim(),
        selectedCategory,
        double.parse(amountController.text),
        isPaid,
      );
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(widget.expenseToEdit == null
              ? "Expense added!"
              : "Expense updated!")),
    );

    Navigator.pop(context); // go back to previous screen
  }

  void resetForm() { // reset form fields
    formKey.currentState?.reset();
    nameController.clear();
    descriptionController.clear();
    amountController.clear();
    setState(() {
      selectedCategory = category[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Expense Entry")), // title
      drawer: MyDrawer(),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16), // pading around the form
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // align to start
            children: [
              Expanded(
                child: SingleChildScrollView(
                  // make the whole thing scrollable
                  child: Column(
                    children: [
                      Text(
                        "Enter Expense",
                        style: TextStyle(
                          fontSize: 32,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      CustomTextFormFieldWidget(
                        // custom widget with validation
                        labelText: "Name",
                        prefixIcon: const Icon(Icons.label),
                        controller: nameController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter a name";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20), // space

                      CustomTextFormFieldWidget(
                        // custom widget without validation
                        labelText: "Description",
                        prefixIcon: const Icon(Icons.description),
                        controller: descriptionController,
                      ),

                      const SizedBox(height: 20), // space

                      CustomTextFormFieldWidget(
                        // custom widget with validation
                        labelText: "Amount",
                        prefixIcon: const Icon(Icons.attach_money),
                        controller: amountController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter the amount";
                          }
                          if (int.tryParse(value) == null) {
                            return "Amount must be a number";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      CustomDropDownFormFieldWidget(
                        chosenWeather: selectedCategory,
                        weather: category,
                        onChanged: (value) {
                          setState(() {
                            selectedCategory =
                                value ?? category[0]; // default is always Bills
                          });
                        },
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),

              // Save Button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: submitExpenseToFirebase,
                    child: const Text("Save"),
                  ),
                  const SizedBox(width: 30),
                  ElevatedButton(
                    onPressed: resetForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                    child: const Text("Reset"),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              if (widget.expenseToEdit != null)
                ElevatedButton.icon(
                  icon: Icon(Icons.delete),
                  label: Text("Delete"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () async {
                    final provider = Provider.of<ExpenseListProvider>(context,
                        listen: false);
                    await provider.deleteExpense(widget.expenseToEdit!);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Expense deleted")),
                    );
                    Navigator.pop(context);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
