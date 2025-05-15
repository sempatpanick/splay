import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'theme.dart';

SnackbarController successSnackBar(
  String title,
  String message, {
  int durationSecond = 3,
  double width = 400,
  bool isShowIcon = false,
  Color backgroundColor = successColor,
}) {
  return Get.snackbar(
    title,
    message,
    margin: const EdgeInsets.only(top: 16, left: 16.0, right: 16.0),
    padding:
        title.isEmpty
            ? const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 8.0,
              bottom: 15.0,
            )
            : null,
    titleText: title.isEmpty ? const SizedBox() : null,
    messageText:
        isShowIcon || title.isNotEmpty
            ? Text(
              message,
              style: lightTheme.textTheme.labelLarge?.copyWith(
                color: Colors.white,
              ),
            )
            : Center(
              child: Text(
                message,
                style: lightTheme.textTheme.labelLarge?.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
    icon: isShowIcon ? const Icon(Icons.check_circle_outline) : null,
    duration: Duration(seconds: durationSecond),
    colorText: Colors.white,
    backgroundColor: backgroundColor,
    maxWidth: Get.size.width <= 700 ? width : 400,
    dismissDirection: DismissDirection.horizontal,
    borderRadius: 8.0,
  );
}

SnackbarController failedSnackBar(
  String title,
  String message, {
  int durationSecond = 3,
  double width = 400,
  bool isShowIcon = false,
  Color backgroundColor = errorColor,
}) {
  return Get.snackbar(
    title,
    message,
    margin: const EdgeInsets.only(top: 16, left: 16.0, right: 16.0),
    padding:
        title.isEmpty
            ? const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 8.0,
              bottom: 15.0,
            )
            : null,
    titleText: title.isEmpty ? const SizedBox() : null,
    messageText:
        isShowIcon || title.isNotEmpty
            ? Text(
              message,
              style: lightTheme.textTheme.labelLarge?.copyWith(
                color: Colors.white,
              ),
            )
            : Center(
              child: Text(
                message,
                style: lightTheme.textTheme.labelLarge?.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
    icon: isShowIcon ? const Icon(Icons.close, color: Colors.white) : null,
    duration: Duration(seconds: durationSecond),
    colorText: Colors.white,
    backgroundColor: errorColor,
    maxWidth: Get.size.width <= 700 ? width : 400,
    dismissDirection: DismissDirection.horizontal,
    borderRadius: 8.0,
  );
}
