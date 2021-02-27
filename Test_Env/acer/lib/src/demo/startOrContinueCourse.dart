import 'package:acer/src/themes/colors.dart';
import 'package:acer/src/widgets/progressBar.dart';
import 'package:drawerbehavior/drawer_scaffold.dart';
import 'package:drawerbehavior/drawerbehavior.dart';
import 'package:flutter/material.dart';

class StartOrContinueCourse extends StatefulWidget {
  @override
  _StartOrContinueCourseState createState() => _StartOrContinueCourseState();
}

class _StartOrContinueCourseState extends State<StartOrContinueCourse> {
  int selectedMenuItemId;

  @override
  void initState() {
    //selectedMenuItemId = menu.items[0].id;
    super.initState();
  }

  Menu menu = Menu(items: [
    MenuItem(
      id: 1,
      title: "Settings",
      icon: Icons.settings,
    ),
    // MenuItem(
    //   id: 1,
    //   title: "Privacy",
    //   icon: Icons.privacy_tip,
    // ),
    // MenuItem(
    //   id: 1,
    //   title: "Notifications",
    //   //icon: Icons.notifications,
    // ),
  ]);
  @override
  Widget build(BuildContext context) {
    return DrawerScaffold(
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
      drawers: [
        SideDrawer(
          drawerWidth: 175,
          headerView: headerView(context),
          percentage: 0.9,
          menu: menu,
          direction: Direction.left,
          animation: true,
          color: Theme.of(context).primaryColor,
          //selectedItemId: selectedMenuItemId,
          // onMenuItemSelected: (itemId) {
          //   setState(() {
          //     selectedMenuItemId = itemId;
          //   });
          // },
        )
      ],
      builder: (context, id) {
        return Container(
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
              Text(
                "Introduction to what fintech is all about",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget headerView(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 75,
        ),
        Container(
          color: Theme.of(context).primaryColorDark,
          height: 120,
          width: 175,
          child: IconButton(
              icon: Icon(
                Icons.play_circle_filled,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {}),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: 170,
          child: Text(
            "The Future of Payment Technology",
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ),
        progressBar(
          context: context,
          height: 10,
          width: 170,
          percentage: 0.58,
          progressColor: darkGreen,
        ),
        Text(
          "58% Completed",
          style: Theme.of(context).textTheme.overline.copyWith(
                color: whiteGreen,
              ),
        ),
        SizedBox(
          height: 6,
        ),
        Row(
          children: [
            Icon(
              Icons.person,
              color: whiteGreen,
              size: 17,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Angela Yu",
              style: Theme.of(context)
                  .textTheme
                  .overline
                  .copyWith(fontSize: 14, color: whiteGreen),
            ),
          ],
        ),
      ],
    ),
  );
}

// AspectRatio(
//         aspectRatio: 15 / 8,
//         child: Image(
//           image: AssetImage("assets/pictures/course_pic.jpg"),
//           height: 70,
//         ),
//       ),