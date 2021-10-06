import 'package:androidtv/myWidgets/firstRow.dart';
import 'package:androidtv/myWidgets/myButton.dart';
import 'package:androidtv/myWidgets/thirdRow.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
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
          'Login',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        SizedBox(height: 40),
        MyButton(
          child: Text(
            'Login with Google',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          width: 300,
          height: 40,
          focusColor: Color.fromARGB(255, 98, 0, 238),
        ),
        SizedBox(height: 10),
        MyButton(
          child: Text(
            'Login with Phone No.',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          width: 300,
          height: 40,
          focusColor: Color.fromARGB(255, 98, 0, 238),
        ),
        SizedBox(height: 10),
        MyButton(
          child: Text(
            'Login with Email Id',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          width: 300,
          height: 40,
          focusColor: Color.fromARGB(255, 98, 0, 238),
        ),
      ],
    );
  }
}
