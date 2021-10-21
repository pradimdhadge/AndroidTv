import 'package:androidtv/myWidgets/firstRow.dart';
import 'package:androidtv/myWidgets/myButton.dart';
import 'package:androidtv/myWidgets/thirdRow.dart';
import 'package:androidtv/screens/vOtpScreen.dart';
import 'package:androidtv/server/server_call.dart';
import 'package:androidtv/server/server_urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LwpScreen extends StatefulWidget {
  static final GlobalKey<FormFieldState<String>> _numkey =
      GlobalKey<FormFieldState<String>>();

  @override
  _LwpScreenState createState() => _LwpScreenState();
}

class _LwpScreenState extends State<LwpScreen> {
  FocusNode vfocus = new FocusNode();
  bool inProcess = false;
  TextEditingController _mobileNoController = new TextEditingController();

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
          'Phone No.',
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
                controller: _mobileNoController,
                key: LwpScreen._numkey,
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
                onSubmitted: (value) {
                  FocusScope.of(context).requestFocus(vfocus);
                },
              ),
            )
          ],
        ),
        SizedBox(height: 20),
        MyButton(
          child: Text(
            'Send Otp',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          width: 100,
          height: 35,
          focusColor: Color.fromARGB(255, 98, 0, 238),
          onTap: () async {
            String _mobileNo = _mobileNoController.value.text;
            if (_mobileNo.isEmpty || _mobileNo == '') {
              Fluttertoast.showToast(msg: 'Enter valid mobile number');
              return false;
            }
            setState(() {
              inProcess = true;
            });
            Map response = await ServerCall().postRequest(
                path: Urls.loginOtp, arguments: {'mobile_no': _mobileNo});
            setState(() {
              inProcess = false;
            });
            if (response['statusCode'] == 200) {
              if (response['status'] == 'TXN') {
                Fluttertoast.showToast(msg: response['message']);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => VotpScreen(_mobileNo)));
              }
            }
          },
          inProcess: inProcess,
          focusNode: vfocus,
        ),
      ],
    );
  }
}
