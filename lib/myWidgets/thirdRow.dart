import 'package:androidtv/myWidgets/myButton.dart';
import 'package:flutter/material.dart';

thirdRow() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Don't have an account?",
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
      SizedBox(height: 20),
      MyButton(
        child: Text(
          'Sign Up',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        width: 100,
        height: 35,
        focusColor: Color.fromARGB(255, 98, 0, 238),
      ),
    ],
  );
}
