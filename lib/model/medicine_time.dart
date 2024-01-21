import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medminder/model/medicine.dart';

class MedicineTime {
  final Medicine medicine;
  final DateTime time;

  MedicineTime(this.medicine, this.time);
}
