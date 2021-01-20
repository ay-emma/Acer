import 'package:acer/src/themes/colors.dart';
import 'package:acer/src/widgets/buttons.dart';
import 'package:acer/src/widgets/progressBar.dart';
import 'package:acer/src/widgets/slider.dart';
import 'package:acer/src/widgets/tab_views.dart';
import 'package:acer/src/widgets/testimonies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

import '../../main.dart';

class UserCoursesPage extends HookWidget {
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
                expandedHeight: 200.0,
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
                      "My Courses",
                      style: TextStyle(
                        fontSize: 21,
                        color: lightGreen,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 33,
                      top: 2,
                      bottom: 9,
                      right: 6,
                    ),
                    width: 100,
                    child: Divider(
                      height: 5,
                      thickness: 4,
                      color: lightGreen,
                      indent: 6,
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 250,
                      height: 310,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: gThemes.currentTheme.accentColor,
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                                child: Image(
                                  //color: Colors.amber,
                                  fit: BoxFit.cover,
                                  image:
                                      AssetImage("assets/logo/acer_light.png"),
                                  height: 70,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                                color: gThemes.currentTheme.accentColor,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 18, horizontal: 10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "App Development with Flutter",
                                      style: gThemes
                                          .currentTheme.textTheme.subtitle2,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      width: 229,
                                      height: 10,
                                      child: Stack(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: gThemes.currentTheme
                                                  .scaffoldBackgroundColor,
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: lightGreen,
                                            ),
                                            width: 150,
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text("58% Completed",
                                        style: gThemes
                                            .currentTheme.textTheme.overline),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.person,
                                          color: lightGreen,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Angela Yu",
                                          style: gThemes
                                              .currentTheme.textTheme.overline
                                              .copyWith(fontSize: 14),
                                        ),
                                      ],
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
          )),
    );
  }
}
