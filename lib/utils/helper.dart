import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToast(String text, {Toast length = Toast.LENGTH_SHORT}) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey,
      timeInSecForIos: 1,
      textColor: Colors.black,
      fontSize: 16.0);
}
