import 'package:acer/src/themes/colors.dart';
import 'package:acer/src/widgets/buttons.dart';
import 'package:acer/src/widgets/slider.dart';
import 'package:acer/src/widgets/tab_views.dart';
import 'package:acer/src/widgets/testimonies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

import '../../main.dart';

class FeaturePage extends HookWidget {
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
                  SliderAnim(),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Text(
                          "Course Categories",
                          style: Theme.of(context).textTheme.headline5,
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 300,
                    width: double.infinity,
                    child: TabView(),
                  ),
                  TestimoniesSection(),
                  SizedBox(
                    height: 30,
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
