import 'package:acer/src/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../main.dart';

class LoginPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final gThemes = useProvider(currentTheme);
    final themmeData = gThemes.currentTheme;
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
    final FocusScopeNode _focus = FocusScopeNode();
    // @override
    // void dispose() {
    //   _focus.dispose();
    //   super.dispose();
    // }

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
                // color: themmeData.scaffoldBackgroundColor,
                child: Column(
                  children: [
                    SizedBox(height: 45),
                    SizedBox(height: 70),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Form(
                        key: _formKey1,
                        child: FocusScope(
                          node: _focus,
                          child: Column(
                            children: [
                              formFields(
                                focus: _focus,
                                themes: themmeData,
                                lebelText: "Enter your name",
                                hintText: "Enter your fullname",
                                validate: validatapass,
                              ),
                              SizedBox(height: 20),
                              formFields(
                                focus: _focus,
                                themes: themmeData,
                                lebelText: "Enter your name",
                                hintText: "Enter your fullname",
                                validate: validatapass,
                              ),
                              otherOptions(),
                              SizedBox(height: 20),
                              MaterialButton(
                                focusColor: midGreen,
                                elevation: 8,
                                onPressed: () {
                                  gThemes.toggleTheme();
                                  if (_formKey1.currentState.validate()) {
                                    // Process data.
                                  }
                                },
                                color: lightGreen,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                minWidth: 80,
                                height: 45,
                                child: Text(
                                  "Login",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: -width * 0.2,
            top: -height * 0.12,
            child: Container(
              height: height * 0.5,
              width: width * 1.1,
              //color: Colors.white,
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

  Widget formFields(
      {FocusScopeNode focus,
      Function validate,
      ThemeData themes,
      String lebelText,
      String hintText}) {
    return TextFormField(
      // key: _formKey1,
      validator: validate,
      minLines: 1,
      maxLines: 1,
      autocorrect: true,
      autofocus: true,
      onEditingComplete: () => focus.nextFocus(),
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: lebelText,
        hintText: hintText,
        labelStyle: TextStyle(color: lightGreen),
        hintStyle: TextStyle(color: lightGreen),
        filled: true,
        fillColor: themes.scaffoldBackgroundColor,
        hoverColor: themes.scaffoldBackgroundColor,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          borderSide: BorderSide(color: Colors.red),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          borderSide: BorderSide(color: lightGreen),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          borderSide: BorderSide(color: lightGreen),
        ),
      ),
    );
  }

  String validatapass(String val) {
    if (val.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  Widget otherOptions() {
    return Column(
      children: [
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
      ],
    );
  }
}
