import 'package:acer/src/themes/colors.dart';
import 'package:flutter/material.dart';

class TabView extends StatefulWidget {
  @override
  _TabViewState createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: DefaultTabController(
        length: 5,
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                margin: const EdgeInsets.only(
                  left: 10,
                ),
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: TabBar(
                  isScrollable: true,
                  indicatorColor: lightGreen,
                  tabs: [
                    Tab(
                      text: "Marketing",
                    ),
                    Tab(
                      text: "IT & Software",
                    ),
                    Tab(
                      text: "Bussiness",
                    ),
                    Tab(
                      text: "Bussiness",
                    ),
                    Tab(
                      text: "Bussiness",
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 250,
              width: double.infinity,
              child: TabBarView(
                children: [
                  CourseCard(),
                  Icon(Icons.directions_transit),
                  Icon(Icons.directions_bike),
                  Icon(Icons.directions_transit),
                  Icon(Icons.directions_bike),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  const CourseCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: AspectRatio(
                aspectRatio: 40 / 60,
                child: NewWidget(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: AspectRatio(
                aspectRatio: 40 / 60,
                child: NewWidget(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: AspectRatio(
                aspectRatio: 40 / 60,
                child: NewWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(20)),
      //height: 150,
      // width: 150,
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Image(
                fit: BoxFit.cover,
                image: AssetImage("assets/pictures/course_pic.jpg"),
                height: 70,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 2, 8, 8),
              child: Column(
                children: [
                  Text(
                    "App Development with flutter",
                    style: Theme.of(context).textTheme.caption,
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Adams Savage",
                        style: Theme.of(context).textTheme.overline,
                      ),
                      Row(
                        children: [
                          Text(
                            "4.5",
                            style: Theme.of(context).textTheme.overline,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 11,
                          )
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: MaterialButton(
                      elevation: 0,
                      color: lightGreen,
                      height: 30,
                      hoverColor: darkGreen.withOpacity(0.5),
                      onPressed: () {},
                      child: Text(
                        "Free",
                        style: TextStyle(fontSize: 12, color: white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
