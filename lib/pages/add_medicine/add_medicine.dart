import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:medminder/service/databaseService.dart';
import 'package:medminder/pages/add_medicine/date_buttons.dart';
import 'package:medminder/pages/add_medicine/generate_med_types.dart';
import 'package:medminder/pages/add_medicine/time_buttons.dart';
import 'package:medminder/model/medicine_type.dart';
import 'package:medminder/service/notificationService.dart';

class AddMedicine extends StatefulWidget {
  const AddMedicine({super.key});

  @override
  State<AddMedicine> createState() => AddMedicineState();
}

class AddMedicineState extends State<AddMedicine> {
  final formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var amountController = TextEditingController();
  bool loadingVisible = false;
  DateTime? startDate;
  DateTime? endDate;
  List<DateTime> times = [];
  MedicineType? medType =
      MedicineType("Syrup", "assets/medicines/syrup.png", true);

  List<Timestamp> convertToTimestampList(List<DateTime> times) {
    List<Timestamp> ts = [];
    for (var time in times) {
      ts.add(Timestamp.fromDate(time));
    }
    return ts;
  }

  @override
  Widget build(BuildContext context) {
    //final String uid = ModalRoute.of(context)!.settings.arguments as String;
    final FirebaseAuth auth = FirebaseAuth.instance;
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
                const SizedBox(height: 25),

                // SAVE BUTTON!!!
                ElevatedButton(
                  onPressed: () async {
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
                        try {
                          var notificationService = NotificationService();
                          setState(() {});
                          await DatabaseService().createMedicine(
                            uid: auth.currentUser!.uid,
                            name: nameController.text,
                            amount: amountController.text,
                            startDate: Timestamp.fromDate(startDate!),
                            endDate: Timestamp.fromDate(
                                endDate!.add(const Duration(days: 1))),
                            times: convertToTimestampList(times),
                            medType: medType?.toJson(),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  '${nameController.text} added successfully!'),
                              behavior: SnackBarBehavior.floating,
                              duration: const Duration(seconds: 3),
                            ),
                          );
                          for (var time in times) {
                            DateTime notificationTime = DateTime(
                              startDate!.year,
                              startDate!.month,
                              startDate!.day,
                              time.hour,
                              time.minute,
                              time.second,
                            );
                            await notificationService.scheduleNotification(
                                nameController.text, notificationTime);
                          }
                        } catch (e) {
                          print(e);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Failed to add the medicine: $e',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              behavior: SnackBarBehavior.floating,
                              duration: const Duration(seconds: 3),
                              backgroundColor: Colors.red,
                            ),
                          );
                        } finally {
                          Navigator.pop(context);
                        }
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                  child: const SizedBox(
                    width: 180,
                    child: Text(
                      'Save',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Visibility(
                  visible: loadingVisible,
                  child: SpinKitWave(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
