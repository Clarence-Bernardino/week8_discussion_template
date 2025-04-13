import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/expenses_provider.dart';
import '../Utilities/widgets.dart';
import '../Utilities/my_drawer.dart';

class ExpenseEntry extends StatefulWidget {
  const ExpenseEntry({super.key});

  @override
  State<ExpenseEntry> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ExpenseEntry> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String selectedCategory = category[0];  // defualt is bills
  TextEditingController amountController = TextEditingController();

  static final List<String> category = [
    "Bills",
    "Transporation",
    "Food",
    "Utilities",
    "Health",
    "Enterntainment",
    "Miscellanecous",
  ];

  // lifecycle methods
  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    amountController.dispose();
    super.dispose();
  }

  // upload data to Firebase
  Future<void> submitExpenseToFirebase() async {
    if (!formKey.currentState!.validate()) return;

    try {
      await FirebaseFirestore.instance.collection('expenses').add({
        'name': nameController.text.trim(),
        'description': descriptionController.text.trim(),
        'amount': double.parse(amountController.text),
        'category': selectedCategory,        
      })
    }
  }

  // TO REVAMP
  // // empty map to be populated with data later
  // Map<String, String> summary = {};

  // // update summary when the save button is clicked
  // void updateSummary() {
  //   // store the new entry
  //   Map<String, String> newEntry = {
  //     "Name": nameController.text,
  //     if (descriptionController.text.isNotEmpty)
  //       "Nickname": descriptionController.text,
  //     "Age": amountController.text,
  //     "Exercise": exercisedToday ? "Exercised Today!" : "Rest Day",
  //     "Mood": "$selectedCategory ${intensity.roundToDouble()}/10",
  //     "Weather": selectedWeather,
  //   };

  //   // get existing entries for comparison below
  //   var entryHistory = context.read<EntryHistory>().entries;

  //   // check for duplicates (ignore nickname and date)
  //   bool isDuplicate = entryHistory.any((entry) {
  //     for (var key in newEntry.keys) {
  //       if (key == "Nickname" || key == "Date Recorded") continue; // Ignore these fields

  //       if (entry[key] != newEntry[key]) {
  //         return false;
  //       }
  //     }

  //     return true; // if no differences, it's a duplicate
  //   });

  //   if (isDuplicate) {
  //     // show a warning message using scaffoldMessenger(it exists higher in the widget tree)
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text("Duplicate entry detected!")),
  //     );
  //     return;
  //   }

  //   // if not a duplicate, save the entry
  //   setState(() {
  //     summary = newEntry; // update the summary
  //     context.read<EntryHistory>().addEntry(newEntry); // add entry to history
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: const Text("Exercise 5")), // title
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
                      Text("Expenses",
                          style: TextStyle(
                              fontSize: 32, fontStyle: FontStyle.italic)),
                      CustomTextFormFieldWidget(
                        // custom widget with validation
                        labelText: "Name",
                        prefixIcon: Icon(Icons.auto_awesome),
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
                        prefixIcon: Icon(Icons.auto_awesome),
                        controller: descriptionController,
                      ),

                      const SizedBox(height: 20), // space

                      Expanded(
                            child: CustomTextFormFieldWidget(
                              // custom widget with validation
                              labelText: "Amount",
                              prefixIcon: Icon(Icons.auto_awesome),
                              controller: amountController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your age";
                                }
                                if (int.tryParse(value) == null) {
                                  return "Age must be a number";
                                }
                                return null;
                              },
                            ),
                          ),

                      SizedBox(height: 50),

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
                    ],
                  ),
                ),
              ),
              // Save Button

              const SizedBox(height: 10), // space

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomSaveButton(
                    formKey: formKey,
                    updateSummary: () {
                      setState(() {
                        updateSummary();       
                      });
                    },
                  ),

                  const SizedBox(width: 50), // space

                  CustomResetButton(
                    formKey: formKey,
                    resetState: () {
                      setState(() {
                        nameController.clear();
                        descriptionController.clear();
                        amountController.clear();
                        selectedCategory = category[0];
                        summary.clear(); 
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // display summary
              if (summary.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: summary.entries.map((entry) {
                    return Text("${entry.key}: ${entry.value}");
                  }).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}