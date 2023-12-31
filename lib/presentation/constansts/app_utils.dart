import 'package:flutter/material.dart';
import 'package:get/get.dart';
class AppUtils{
  showAlertDialog(String title,String message){
    Get.defaultDialog(
      title: title,
      content: Text(message),
      textConfirm: 'OK',
      onConfirm: () {
        // Do something when the user presses the "OK" button
        Get.back(); // Close the dialog
      },
    );
  }
}