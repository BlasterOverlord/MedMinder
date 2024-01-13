import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// converts DateTime objects to string representing time in AM/PM
String formatTime(DateTime time) {
  final String format = DateFormat.jm().format(time);
  return format;
}

// converts TimeofDay object to DateTime object
DateTime timeofDaytoDateTime(TimeOfDay time) {
  final now = DateTime.now();
  final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
  return dt;
}