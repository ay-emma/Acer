import 'package:acer/src/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../main.dart';

class LoginPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final gThemes = useProvider(currentTheme);
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: width,
            height: height,
            child: FractionallySizedBox(
              alignment: Alignment.bottomCenter,
              widthFactor: 1,
              heightFactor: 0.75,
              child: Container(
                  color: dblack,
                  child: Column(
                    children: [
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
                    ],
                  )),
            ),
          ),
          Positioned(
            left: -90,
            top: -35,
            child: Container(
              height: height * 0.5,
              width: width * 1.2,
              color: Colors.white,
              child: Image(
                fit: BoxFit.contain,
                image: AssetImage("assets/logo/login_light.png"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
