import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  double? height = 50;
  double? width = 200;
  Color? textColor = Colors.white;
  Color? backgroundColor = Colors.transparent;
  Color? focusColor = Colors.white;
  Widget? child;
  FocusNode? focusNode;
  Function()? onTap;

  MyButton(
      {this.height,
      this.width,
      this.textColor,
      this.backgroundColor,
      this.focusColor,
      this.child,
      this.focusNode,
      @required this.onTap});

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  bool isFocus = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: widget.focusColor,
      focusNode: widget.focusNode,
      onFocusChange: (f) {
        setState(() {
          isFocus = f;
        });
      },
      onTap: widget.onTap,
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          color: isFocus ? widget.focusColor : widget.backgroundColor,
          border: isFocus
              ? null
              : Border.all(
                  color: Colors.white,
                  width: 3,
                ),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: widget.child,
        ),
      ),
    );
  }
}
