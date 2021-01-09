import 'package:acer/src/themes/colors.dart';
import 'package:acer/src/themes/theme_model.dart';
import 'package:acer/src/widgets/buttons.dart';
import 'package:acer/src/widgets/slider.dart';
import 'package:acer/src/widgets/tab_views.dart';
import 'package:acer/src/widgets/testimonies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

import '../../main.dart';

class CourseWelcomePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final gThemes = useProvider(currentTheme);

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: gThemes.currentTheme.scaffoldBackgroundColor,
              shadowColor: lightGreen,
              expandedHeight: 120.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                //centerTitle: true,
                titlePadding: const EdgeInsets.all(0),
                title: Container(
                  alignment: Alignment.bottomCenter,
                  // color: Colors.redAccent,
                  child: Image(
                    image: AssetImage("assets/logo/acer_light.png"),
                    height: 70,
                  ),
                ),
                background: Opacity(
                  opacity: 0.3,
                  child: Image.network(
                    "https://static.vecteezy.com/system/resources/previews/000/180/360/non_2x/e-learning-vector-illustration.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ];
        },
        body: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 35,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "The Future of Payment Technology",
                    style: TextStyle(
                      fontSize: 21,
                      color: lightGreen,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 16,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 16,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 16,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 16,
                      ),
                      Text(
                        "4.5 (15 reviews)",
                        style: gThemes.currentTheme.textTheme.caption,
                      )
                    ],
                  ),
                ),
                Container(
                  child: AspectRatio(
                    aspectRatio: 16 / 10,
                    child: Image(
                      image: AssetImage("assets/pictures/course_pic.jpg"),
                      height: 70,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.translate_sharp,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Language:  ",
                            style: gThemes.currentTheme.textTheme.overline,
                          ),
                          //English Language
                          Text(
                            "English Language:",
                            style: gThemes.currentTheme.textTheme.overline
                                .copyWith(color: lightGreen),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.translate_sharp,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Duration:  ",
                            style: gThemes.currentTheme.textTheme.overline,
                          ),
                          //English Language
                          Text(
                            "40 hours:",
                            style: gThemes.currentTheme.textTheme.overline
                                .copyWith(color: lightGreen),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.timer,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Value:  ",
                            style: gThemes.currentTheme.textTheme.overline,
                          ),
                          //English Language
                          Text(
                            "Free:",
                            style: gThemes.currentTheme.textTheme.overline
                                .copyWith(color: lightGreen),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.remove_red_eye,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Views:  ",
                              style: gThemes.currentTheme.textTheme.overline),
                          //English Language
                          Text(
                            "2000 views:",
                            style: gThemes.currentTheme.textTheme.overline
                                .copyWith(color: lightGreen),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                _customPointer(
                    gThemes,
                    "Discover the future of payment technology, from mobile payment to tokenization",
                    "on this course, you will learn new ways of making payments from consumer-to-business (C2B), from consumer-to-consumer (C2C), and from business-to-business (B2B). You will explore current payment system technologies to examine their strength and weaknesses, and understand the ways technological innovation is changing these traditional systems. You'll learn about new front-end innovations like digital wallets and mobile payments and also discover back-end innovations like tokenization, mobile money, and new payment infrastructure."),
                SizedBox(
                  height: 20,
                ),
                _customBulletPointer(
                  gThemes,
                  "what will you archieve?",
                  "Explain how current payment systems operate.",
                ),
                SizedBox(
                  height: 20,
                ),
                _customBulletPointer(
                  gThemes,
                  "Prerequesite and Requirement",
                  "This course is designed for anyone interested in understanding cutting edge financial technologies.This course will be of particular interest to learners with a background in finance, development, or business leadership and learning how to develop and use new financial technologies in their own context.",
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    Button1(),
                    Button2(),
                  ],
                ),
                SizedBox(
                  height: 30,
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
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _customPointer(ThemeModel gThemes, String header, String bodyTexts) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Text(header, style: gThemes.currentTheme.textTheme.headline6),
          SizedBox(
            height: 20,
          ),
          Text(
            bodyTexts,
            style: gThemes.currentTheme.textTheme.bodyText2,
          )
        ],
      ),
    );
  }

  Widget _customBulletPointer(
      ThemeModel gThemes, String header, String bodyTexts) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(header, style: gThemes.currentTheme.textTheme.headline6),
          SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.check_rounded,
                color: lightGreen,
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(
                  bodyTexts,
                  style: gThemes.currentTheme.textTheme.bodyText2,
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.check_rounded,
                color: lightGreen,
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(
                  'Describe inefficiencies in current practices in the processing of payments.',
                  style: gThemes.currentTheme.textTheme.bodyText2,
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.check_rounded,
                color: lightGreen,
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(
                  "Apply new technological innovations to current inefficiencies.",
                  style: gThemes.currentTheme.textTheme.bodyText2,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
