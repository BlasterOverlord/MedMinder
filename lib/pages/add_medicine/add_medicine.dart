import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medminder/pages/add_medicine/generate_med_types.dart';

class AddMedicine extends StatefulWidget {
  const AddMedicine({super.key});

  @override
  State<AddMedicine> createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  final formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var amountController = TextEditingController();

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
                    if (value == null || value.isEmpty) {
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
                    "Type of Medicine",
                    style: theme.textTheme.titleMedium,
                  ),
                ),
                const SizedBox(height: 12),
                const GenerateMedTypes(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
