import 'package:acer/src/themes/colors.dart';
import 'package:acer/src/widgets/courseTabView.dart';
import 'package:acer/src/widgets/tab_views.dart';
import 'package:flutter/material.dart';

class PreStatOrContinueCourse extends StatefulWidget {
  @override
  _PreStatOrContinueCourseState createState() =>
      _PreStatOrContinueCourseState();
}

class _PreStatOrContinueCourseState extends State<PreStatOrContinueCourse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Container(
            alignment: Alignment.topLeft,
            //color: Colors.redAccent,
            child: Image(
              image: AssetImage("assets/logo/acer_light.png"),
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          actions: [IconButton(icon: Icon(Icons.add), onPressed: () {})]),
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            // FlutterLogo(),
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                color: darkGreen,
                //width: 90,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  Text(
                    "Introduction to what fintech is about",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  CourseTabView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
