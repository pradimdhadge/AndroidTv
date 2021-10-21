import 'package:androidtv/myWidgets/firstRow.dart';
import 'package:androidtv/myWidgets/myButton.dart';
import 'package:androidtv/myWidgets/thirdRow.dart';
import 'package:androidtv/server/server_call.dart';
import 'package:androidtv/server/server_urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VotpScreen extends StatelessWidget {
  final String mobileNo;
  VotpScreen(this.mobileNo);

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
                children: [firstRow(), LoginRow(mobileNo), thirdRow()],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginRow extends StatefulWidget {
  final String mobileNo;
  LoginRow(this.mobileNo);

  @override
  _LoginRowState createState() => _LoginRowState();
}

class _LoginRowState extends State<LoginRow> {
  FocusNode vfocus = FocusNode();
  static final GlobalKey<FormFieldState<String>> _numkey =
      GlobalKey<FormFieldState<String>>();

  TextEditingController _otpController = TextEditingController();
  bool inProcess = false;

  Stream<int> _time = (() async* {
    int i = 59;

    for (i; i >= 0; i--) {
      await Future<void>.delayed(const Duration(seconds: 1));
      yield i;
    }
  })();

  void restartTimer() {
    setState(() {
      _time = (() async* {
        int i = 59;

        for (i; i >= 0; i--) {
          await Future<void>.delayed(const Duration(seconds: 1));
          yield i;
        }
      })();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                controller: _otpController,
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
                onCompleted: (value) {
                  FocusScope.of(context).requestFocus(vfocus);
                },
                appContext: context,
                onChanged: (String value) {},
                onSubmitted: (value) {
                  FocusScope.of(context).requestFocus(vfocus);
                },
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            )
          ],
        ),
        StreamBuilder(
          initialData: 59,
          stream: _time,
          builder: (context, snapshot) {
            return snapshot.data != 0
                ? Container(
                    width: 200,
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${snapshot.data}',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : ResendBtn(restartTimer, widget.mobileNo);
          },
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
          inProcess: inProcess,
          onTap: () async {
            final String _otp = _otpController.value.text;
            if (_otp.isEmpty || _otp == '') {
              Fluttertoast.showToast(msg: 'Please enter valid otp');
              return false;
            }

            setState(() {
              inProcess = true;
            });

            Map response = await ServerCall().postRequest(
                path: Urls.vMobileOtp,
                arguments: {'otp': _otp, 'mobile_no': widget.mobileNo});

            setState(() {
              inProcess = false;
            });

            print(response);

            if (response['statusCode'] == 200) {
              if (response['status'] == 'TXN') {
                print(response);
                print('login');
              } else {
                print('fails');
              }
            }
          },
        ),
      ],
    );
  }
}

class ResendBtn extends StatefulWidget {
  final Function _restartTimer;
  final String _mobileNo;
  ResendBtn(this._restartTimer, this._mobileNo);

  @override
  _ResendBtnState createState() => _ResendBtnState();
}

class _ResendBtnState extends State<ResendBtn> {
  bool _isFocused = false;
  bool _inProcess = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      alignment: Alignment.centerRight,
      child: InkWell(
        onFocusChange: (f) {
          setState(() {
            _isFocused = f;
          });
        },
        onTap: () async {
          setState(() {
            _inProcess = true;
          });

          Map response = await ServerCall().postRequest(
              path: Urls.loginOtp, arguments: {'mobile_no': widget._mobileNo});

          setState(() {
            _inProcess = false;
          });

          if (response['statusCode'] == 200) {
            if (response['status'] == 'TXN') {
              Fluttertoast.showToast(msg: response['message']);
              widget._restartTimer();
            }
          } else {
            Fluttertoast.showToast(msg: 'Something went wrong');
          }
        },
        child: _inProcess
            ? Container(
                height: 10,
                width: 10,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ))
            : Text('Resend',
                style: TextStyle(
                    color: _isFocused ? Colors.indigoAccent : Colors.white)),
      ),
    );
  }
}
