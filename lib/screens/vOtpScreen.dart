import 'package:androidtv/myWidgets/firstRow.dart';
import 'package:androidtv/myWidgets/myButton.dart';
import 'package:androidtv/myWidgets/thirdRow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VotpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/login.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [firstRow(), _loginRow(), thirdRow()],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _loginRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Login With Phone',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        SizedBox(height: 20),
        Text(
          'OTP (One Time Password)',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        Row(
          children: [
            Column(
              children: [
                DropdownButton(
                  items: [
                    DropdownMenuItem(
                      child: Text(
                        '+91',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            Container(
              width: 170,
              child: TextField(
                cursorColor: Colors.white,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                style: TextStyle(color: Colors.white, fontSize: 20),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  hintText: 'Enter phone no',
                  hintStyle: TextStyle(color: Colors.white, fontSize: 20),
                  isDense: true,
                  focusColor: Colors.white,
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  counter: Container(),
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 20),
        MyButton(
          child: Text(
            'Verify',
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
}
