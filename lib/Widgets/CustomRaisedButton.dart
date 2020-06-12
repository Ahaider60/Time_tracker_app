import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
//Global Variables

  final Color color;
  final Widget child;
  final double borderRadius;
  final VoidCallback onPressed;

  const CustomRaisedButton(
      {Key key,
      @required this.color,
      this.borderRadius: 15.0,
      this.onPressed,
      this.child})
      : assert(color != null);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: RaisedButton(
        child: child,
        onPressed: onPressed,
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        ),
      ),
    );
  }
}
