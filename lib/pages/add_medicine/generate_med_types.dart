import 'package:flutter/material.dart';
import 'package:medminder/model/medicine_type.dart';

class GenerateMedTypes extends StatefulWidget {
  final Function(MedicineType) onTypeChanged;
  const GenerateMedTypes({super.key, required this.onTypeChanged});

  @override
  State<GenerateMedTypes> createState() => _GenerateMedTypesState();
}

class _GenerateMedTypesState extends State<GenerateMedTypes> {
  List<MedicineType> medicineTypes = [
    MedicineType("Syrup", "assets/medicines/syrup.png", true),
    MedicineType("Pill", "assets/medicines/pill.png", false),
    MedicineType("Drops", "assets/medicines/drops.png", false),
    MedicineType("Cream", "assets/medicines/cream.png", false),
    MedicineType(
        "Injection", "assets/medicines/syringe.png", false),
  ];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: medicineTypes.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                for (var element in medicineTypes) {
                  element.isChoose = false;
                }
                medicineTypes[index].isChoose = true;
                widget.onTypeChanged(medicineTypes[index]);
              });
            },
            child: SizedBox(
              width: 100,
              child: Card(
                color: medicineTypes[index].isChoose
                    ? theme.colorScheme.primary
                    : theme.colorScheme.background,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: Image.asset(medicineTypes[index].imgPath),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      medicineTypes[index].name,
                      style: TextStyle(
                        color: medicineTypes[index].isChoose
                            ? theme.colorScheme.onPrimary
                            : theme.colorScheme.onBackground,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
