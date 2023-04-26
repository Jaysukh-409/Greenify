import 'package:flutter/material.dart';
import 'package:get/get.dart';

showSnackBar(String title, String message, BuildContext context) {
  Get.snackbar(title, message, snackPosition: SnackPosition.BOTTOM);
}
