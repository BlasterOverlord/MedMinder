import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medminder/model/medicine_time.dart';
import 'package:medminder/model/medicine_type.dart';
import 'package:medminder/model/medicine.dart';
import 'package:medminder/model/user.dart';

class DatabaseService {
  // creating an instance of firebase auth to allow us to communicate with firebase auth class
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // firestore collection reference
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference medicineCollection =
      FirebaseFirestore.instance.collection('medicine');

  // create a new document for the user with the uid
  Future createUserDoc(String uid, String name, String email) async {
    final docUser = _userCollection.doc(uid);
    final CustomUser customUser = CustomUser(uid, name, email);

    final jsonUser = customUser.toJson();
    return await docUser.set(jsonUser);
  }

  Future registerUser(String name, String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      await createUserDoc(user!.uid, name, email);
      return CustomUser(user.uid, name, email);
    } catch (message) {
      print("Regsiter Error message: ${message.toString()}");
      return message;
    }
  }

  // Map snapshot into CustomUser object
  CustomUser userObjectFromSnapshot(DocumentSnapshot snapshot) {
    return CustomUser(
      snapshot.id,
      snapshot.get('name'),
      snapshot.get('email'),
    );
  }

  Stream<CustomUser> getUserByUserID(String uid) {
    return _userCollection.doc(uid).snapshots().map(userObjectFromSnapshot);
  }

  Future loginUser(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (message) {
      print(message.toString());
      return message.toString();
    }
  }

  Future logoutUser() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future createMedicine(
      {required String uid,
      required String name,
      String? amount,
      required Timestamp? startDate,
      required Timestamp? endDate,
      required List<Timestamp> times,
      required Map<String, dynamic>? medType}) async {
    final docMed = medicineCollection.doc();
    final Medicine med = Medicine(
      id: docMed.id,
      uid: uid,
      name: name,
      amount: amount,
      startDate: startDate,
      endDate: endDate,
      times: times,
      medType: medType,
    );
    final jsonMed = med.toJson();

    return await docMed.set(jsonMed);
  }

  List<MedicineTime> medListFromSnapshot(
      QuerySnapshot snapshot, DateTime selectedDate) {
    List<MedicineTime> allMedicineTimes = [];
    try {
      List<Medicine> medList = snapshot.docs
          .map((doc) => Medicine(
                id: doc.id,
                uid: doc.get('uid'),
                name: doc.get('name'),
                amount: doc.get('amount'),
                startDate: doc.get('startDate'),
                endDate: doc.get('endDate'),
                times: List<Timestamp>.from(doc.get('times')),
                medType: doc.get('medType'),
              ))
          .toList();

      print('Hour: ${selectedDate.hour}  Min: ${selectedDate.minute}');
      for (var med in medList) {
        if ((selectedDate.isAtSameMomentAs(med.startDate!.toDate()) ||
                selectedDate.isAfter(med.startDate!.toDate())) &&
            (selectedDate.isAtSameMomentAs(med.endDate!.toDate()) ||
                selectedDate.isBefore(med.endDate!.toDate()))) {
          for (var time in med.times) {
            DateTime medTime = time.toDate();
            DateTime newMedTime = DateTime(
              selectedDate.year,
              selectedDate.month,
              selectedDate.day,
              medTime.hour,
              medTime.minute,
            );
            allMedicineTimes.add(MedicineTime(med, newMedTime));
          }
        }
      }
    } catch (e) {
      print(e);
    } finally {
      allMedicineTimes.sort((a, b) => a.time.compareTo(b.time));
      return allMedicineTimes;
    }
  }

  Stream<List<MedicineTime>> getMedicineTimesByUserID(
      String uid, DateTime selectedDate) {
    return medicineCollection
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map((snapshot) => medListFromSnapshot(snapshot, selectedDate));
  }
}
