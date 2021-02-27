import 'package:acer/src/themes/colors.dart';
import 'package:acer/src/widgets/buttons.dart';
import 'package:flutter/material.dart';

class CourseTabView extends StatefulWidget {
  @override
  _CourseTabViewState createState() => _CourseTabViewState();
}

class _CourseTabViewState extends State<CourseTabView> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: DefaultTabController(
        initialIndex: 1,
        length: 3,
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
                      text: "Resources",
                    ),
                    Tab(
                      text: "Q/A",
                    ),
                    Tab(
                      text: "Announcement",
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 310,
              width: double.infinity,
              child: TabBarView(
                children: [
                  CourseCard(),
                  _qASection(context),
                  _commentsSection(context),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _commentsSection(BuildContext context) {
  return Container(
    child: Column(
      children: [
        Text("29 Comment"),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).accentColor,
                child: Icon(
                  Icons.person,
                  color: Theme.of(context).primaryColor.withOpacity(0.46),
                ),
              ),
            ),
            Container(
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width * 0.70,
              ),
              // width: double.infinity,
              //height: 160,
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Mark Jason ",
                        ),
                        Text(
                          "3 months ago",
                          style: TextStyle(
                            fontSize: 10,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    //color: Colors.red,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    width: MediaQuery.of(context).size.width * 0.663,
                    child: Text(
                      "I Angellla I did the course three months but the way forward was to go backwarrds in other to see the way forward ago  can I skip the next part?",
                      //softWrap: true,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _qASection(BuildContext context) {
  return Container(
    child: ListView(
      children: [
        Text("Post a comment"),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CircleAvatar(),
            ),
            Container(
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width * 0.70,
              ),
              // width: double.infinity,
              height: 160,
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 10,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.58,
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      child: Column(
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            minLines: 2,
                            maxLines: 4,
                          ),
                          Expanded(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.58,
                              alignment: Alignment.centerLeft,
                              color: Theme.of(context).scaffoldBackgroundColor,
                              child: IconButton(
                                padding: const EdgeInsets.all(2),
                                icon: Icon(
                                  Icons.add_a_photo,
                                  size: 20,
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Button1(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// Container(
//                       height: 30,
//                       width: 30,
//                       child: Transform.rotate(
//                         angle: -110,
//                         child: CustomPaint(
//                           painter: _ChatArrow(Colors.red),
//                           child: Container(
//                             height: 10,
//                             width: 10,
//                           ),
//                         ),
//                       ),
//                     ),
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

class _ChatArrow extends CustomPainter {
  final Color color;

  _ChatArrow(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = color;
    var path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.height, size.width);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
