import 'package:androidtv/screens/loginScreen.dart';
import 'package:androidtv/screens/lwpScreen.dart';
import 'package:androidtv/screens/vOtpScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

main() {
  runApp(TvApp());
}

class TvApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.select): ActivateIntent(),
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    );
  }
}
