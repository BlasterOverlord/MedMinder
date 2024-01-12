import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medminder/pages/add_medicine/date_buttons.dart';
import 'package:medminder/pages/add_medicine/generate_med_types.dart';
import 'package:medminder/pages/add_medicine/time_buttons.dart';
import 'package:medminder/model/medicine_type.dart';

class AddMedicine extends StatefulWidget {
  const AddMedicine({super.key});

  @override
  State<AddMedicine> createState() => AddMedicineState();
}

class AddMedicineState extends State<AddMedicine> {
  final formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var amountController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;
  List<TimeOfDay> times = [];
  MedicineType? medType;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Medicine",
          style: theme.textTheme.headlineSmall,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a medicine name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Medicine Name",
                    hintText: "Enter the medicine name",
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 25),
                TextFormField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    labelText: "Amount",
                    hintText: "Enter the amount of medicine",
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 25),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Duration",
                    style: theme.textTheme.titleMedium,
                  ),
                ),
                const SizedBox(height: 12),

                // DATE PICKER!!!
                DatePickerButtons(
                  onStartChanged: (pickedDate) => startDate = pickedDate,
                  onEndChanged: (pickedDate) => endDate = pickedDate,
                ),
                const SizedBox(height: 25),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Type of Medicine",
                    style: theme.textTheme.titleMedium,
                  ),
                ),
                const SizedBox(height: 12),

                // TYPE OF MEDS!!!
                GenerateMedTypes(
                  onTypeChanged: (med) => medType = med,
                ),
                const SizedBox(height: 20),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Time",
                    style: theme.textTheme.titleMedium,
                  ),
                ),
                const SizedBox(height: 12),

                // TIME PICKER!!!
                TimePickerButtons(
                  onTimeChanged: (selectedTimes) => times = selectedTimes,
                ),
              ],
            ),
          ),
        ),
      ),

      // SAVE BUTTON!!!
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (startDate == null || endDate == null) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Duration Not Set!'),
                  content: const Text(
                      'Please make sure you set a start date and an end date for your medicine.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          } else if (times.isEmpty) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Time Not Set!'),
                  content: const Text(
                      'Please make sure you add a time for your medicine.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          } else {
            if (formKey.currentState!.validate()) {
              Navigator.pop(context);
            }
          }
        },
        label: const Text('save'),
        icon: const Icon(Icons.save_rounded),
      ),
    );
  }
}
