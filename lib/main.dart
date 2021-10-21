import 'package:androidtv/screens/loginScreen.dart';
import 'package:androidtv/screens/lwpScreen.dart';
import 'package:androidtv/screens/playList.dart';
import 'package:androidtv/screens/vOtpScreen.dart';
import 'package:androidtv/screens/videoPlayer.dart';
import 'package:androidtv/screens/videoScreen.dart';
import 'package:androidtv/screens/youtube_screen.dart';
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
        home: PlayList(),
      ),
    );
  }
}
