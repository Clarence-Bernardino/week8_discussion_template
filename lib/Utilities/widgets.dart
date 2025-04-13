import 'package:flutter/material.dart';

// WIDGETS FILE

// save button Widget
class CustomSaveButton extends StatelessWidget {
  final GlobalKey<FormState> formKey; // current form state tracker
  final VoidCallback updateSummary;   // function to update summary

  // constructor
  const CustomSaveButton({required this.formKey, required this.updateSummary});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (formKey.currentState!.validate()) { // validate fields
          formKey.currentState!.save(); // save if valid
          updateSummary(); // update summary after saving
        } else {
          print("Errors detected"); // error message
        }
      },
      child: Text("Save"),
    );
  }
}

// Reset Button Widget
class CustomResetButton extends StatelessWidget {
  final GlobalKey<FormState> formKey; // current form state tracker
  final VoidCallback resetState;      // function to reset state

  // constructor
  const CustomResetButton({required this.formKey, required this.resetState});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        formKey.currentState!.reset(); // reset form fields
        resetState(); // reset other variables
      },
      child: Text("Reset"),
    );
  }
}

// drop down form field for weather
class CustomDropDownFormFieldWidget extends StatelessWidget {
  final String chosenWeather; // currently seleted weather
  final List<String> weather; // list of available weather options
  final Function(String?) onChanged;  // function for selection changes

  // constructor
  const CustomDropDownFormFieldWidget({
    Key? key,
    required this.chosenWeather,
    required this.weather,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      dropdownColor: Theme.of(context).colorScheme.surface, // bg color when dropped
      value: chosenWeather, // display selected weather
      items: weather.map((weatherItem) {
        return DropdownMenuItem(
          value: weatherItem,
          child: Text(weatherItem),
        );
      }).toList(), // store items into list
      onChanged: onChanged, // onChanged can be customized
      
      onSaved: (value) {
        value = chosenWeather;  // save the selected weather
      },
    );
  }
}

// custom form field widget for general use, can have a validator or not
class CustomTextFormFieldWidget extends StatelessWidget {
  final String labelText;
  final Icon? prefixIcon; // optional icon
  final TextEditingController controller;
  final String? Function(String?)? validator; // optional validator, can be left null

  // constructor
  const CustomTextFormFieldWidget({
    Key? key,
    required this.labelText,
    this.prefixIcon,
    required this.controller,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.zero, // rectangle
        ),
      ),
      controller: controller,
      validator: validator,
    );
  }
}
