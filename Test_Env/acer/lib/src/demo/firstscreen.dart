import 'package:acer/src/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

import '../../main.dart';

class FirstPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final gThemes = useProvider(currentTheme);
    return Scaffold(
      body: Container(
        //color: Colors.blueGrey,
        child: Center(
          child: Column(
            children: [
              Image(image: AssetImage("assets/logo/acer_icon.png")),
              Text(
                "Sign Up Via",
                style: TextStyle(
                  fontSize: 51,
                  fontWeight: FontWeight.w700,
                  color: lightGreen,
                ),
              ),
              SizedBox(
                height: 55,
              ),
              Container(
                width: 180,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image(image: AssetImage("assets/icons/twitter_icon.png")),
                    Image(image: AssetImage("assets/icons/google_icon.png")),
                    Image(image: AssetImage("assets/icons/twitter_icon.png")),
                  ],
                ),
              ),
              SizedBox(
                height: 45,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 70,
                    child: Divider(
                      height: 10,
                      thickness: 3,
                      color: lightGreen,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "OR",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: lightGreen,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 70,
                    child: Divider(
                      height: 10,
                      thickness: 3,
                      color: lightGreen,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              MaterialButton(
                onPressed: () {
                  gThemes.toggleTheme();
                },
                color: lightGreen,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                minWidth: 80,
                height: 45,
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              TextField()
            ],
          ),
        ),
      ),
    );
  }
}
