import 'package:androidtv/myWidgets/myButton.dart';
import 'package:flutter/material.dart';

firstRow() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(child: Container()),
      Expanded(
        child: Icon(
          Icons.tv,
          color: Colors.white,
          size: 50,
        ),
      ),
      Expanded(
        child: Container(
          height: 35,
          width: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.language,
                      color: Colors.white,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'English',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                height: 35,
                width: 120,
                focusColor: Color.fromARGB(255, 98, 0, 238),
                onTap: () {},
              ),
            ],
          ),
        ),
      )
    ],
  );
}
