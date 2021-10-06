import 'package:androidtv/myWidgets/firstRow.dart';
import 'package:androidtv/myWidgets/myButton.dart';
import 'package:androidtv/myWidgets/thirdRow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VotpScreen extends StatelessWidget {
  FocusNode vfocus = FocusNode();
  static final GlobalKey<FormFieldState<String>> _numkey =
      GlobalKey<FormFieldState<String>>();

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
                children: [firstRow(), _loginRow(context), thirdRow()],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _loginRow(BuildContext context) {
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
        SizedBox(height: 10),
        Row(
          children: [
            Container(
              width: 200,
              child: PinCodeTextField(
                key: _numkey,
                length: 6,
                obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.underline,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 40,
                  fieldWidth: 30,
                  activeFillColor: Colors.white,
                ),
                animationDuration: Duration(milliseconds: 300),
                enableActiveFill: true,
                beforeTextPaste: (text) {
                  print("Allowing to paste $text");
                  return true;
                },
                appContext: context,
                onChanged: (String value) {},
                onSubmitted: (value) {
                  FocusScope.of(context).requestFocus(vfocus);
                },
              ),
            )
          ],
        ),
        Container(
          width: 200,
          alignment: Alignment.centerRight,
          child: InkWell(
            child: Text('00 : 59', style: TextStyle(color: Colors.white)),
          ),
        ),
        MyButton(
          child: Text(
            'Verify',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.right,
          ),
          width: 100,
          height: 35,
          focusColor: Color.fromARGB(255, 98, 0, 238),
          focusNode: vfocus,
        ),
      ],
    );
  }
}
