import 'package:cloud_firestore/cloud_firestore.dart';

class Medicine {
  String? id;
  String? uid;
  String? name;
  String? amount;
  Timestamp? startDate;
  Timestamp? endDate;
  List<Timestamp> times = [];
  Map<String,dynamic>? medType;

  Medicine({
    required this.id,
    required this.uid,
    required this.name,
    this.amount,
    required this.startDate,
    required this.endDate,
    required this.times,
    required this.medType,
  });

  Map<String, dynamic> toJson() => {
      'id': id,
      'uid': uid,
      'name': name,
      'amount': amount,
      'startDate': startDate,
      'endDate': endDate,
      'times': times,
      'medType': medType,
    };


  static Medicine fromJson(Map<String, dynamic> json) => Medicine(
      id: json['id'],
      uid: json['uid'],
      name: json['name'],
      amount: json['amount'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      times: List<Timestamp>.from(json['times']),
      medType: json['medType'],
    );
}



