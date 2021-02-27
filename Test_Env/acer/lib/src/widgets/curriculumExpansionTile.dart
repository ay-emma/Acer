import 'package:acer/src/themes/colors.dart';
import 'package:acer/src/themes/theme_model.dart';
import 'package:flutter/material.dart';

import 'courseExpansionTile.dart';

class CurriculumExpansionTile extends StatelessWidget {
  const CurriculumExpansionTile({
    Key key,
    @required this.gThemes,
  }) : super(key: key);

  final ThemeModel gThemes;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.88,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: gThemes.currentTheme.accentColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: CourseExpansionTiles(
          backgroundColor: gThemes.currentTheme.accentColor,
          tilePadding: const EdgeInsets.symmetric(horizontal: 0),
          //collapsedBackgroundColor: gThemes.currentTheme.accentColor,
          title: Text(
            "Course Curriculum",
            style: gThemes.currentTheme.textTheme.bodyText1,
          ),
          children: [
            Container(
              decoration: BoxDecoration(
                color: gThemes.currentTheme.scaffoldBackgroundColor,
                border: Border.all(
                  width: 3,
                  color: gThemes.currentTheme.accentColor,
                ),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Icon(
                      Icons.now_wallpaper,
                      color: lightGreen,
                      size: 18,
                    ),
                  ),
                  Container(
                    width: 4,
                    height: 30,
                    color: gThemes.currentTheme.accentColor,
                  ),
                  Expanded(
                    child: Text("Section 1: Introduction to fintech",
                        softWrap: false,
                        overflow: TextOverflow.fade,
                        style: gThemes.currentTheme.textTheme.bodyText1),
                  ),
                ],
              ),
            ),

            // dfds
            CurriculumTile(gThemes: gThemes),
            Text("Course Curriculum"),
            Text("Course Curriculum"),
          ],
        ),
      ),
    );
  }
}

class CurriculumTile extends StatelessWidget {
  const CurriculumTile({
    Key key,
    @required this.gThemes,
  }) : super(key: key);

  final ThemeModel gThemes;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: gThemes.currentTheme.scaffoldBackgroundColor,
        border: Border.all(
          width: 3,
          color: gThemes.currentTheme.accentColor,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Icon(
              Icons.now_wallpaper,
              color: lightGreen,
              size: 18,
            ),
          ),
          Container(
            width: 4,
            height: 30,
            color: gThemes.currentTheme.accentColor,
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(2),
              color: gThemes.currentTheme.scaffoldBackgroundColor,
              child: Row(
                children: [
                  Icon(
                    Icons.play_arrow_rounded,
                    color: lightGreen,
                    size: 18,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: Text(
                      "Section 1: Introduction to fintech",
                      softWrap: false,
                      overflow: TextOverflow.fade,
                      style: gThemes.currentTheme.textTheme.bodyText2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
