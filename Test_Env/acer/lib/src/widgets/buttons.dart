import 'package:acer/src/themes/colors.dart';
import 'package:flutter/material.dart';

class Button1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RawMaterialButton(
        onPressed: () {},
        elevation: 0,
        child: Text("Login"),
        fillColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
      ),
    );
  }
}

class Button2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RawMaterialButton(
        onPressed: () {},
        elevation: 0,
        child: Text(
          "Sign Up",
          style: TextStyle(color: lightGreen),
        ),
        //fillColor: Theme.of(context).accentColor,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: lightGreen),
            borderRadius: BorderRadius.circular(13)),
      ),
    );
  }
}
