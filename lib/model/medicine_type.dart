import 'package:flutter/material.dart';

class MedicineType {
  String name;
  String imgPath;
  bool isChoose;

  MedicineType(this.name, this.imgPath, this.isChoose);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': imgPath
    };
  }
}
