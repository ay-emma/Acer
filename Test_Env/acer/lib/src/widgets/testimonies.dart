import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class TestimoniesSection extends StatefulWidget {
  @override
  _TestimoniesSectionState createState() => _TestimoniesSectionState();
}

class _TestimoniesSectionState extends State<TestimoniesSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "From the Community",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          CarouselSlider(
              items: data.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        //margin: EdgeInsets.symmetric(horizontal: 5.0),
                        //decoration: BoxDecoration(color: Colors.amber),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage(i.pic),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Expanded(
                              child: Text(
                                i.text,
                                style: Theme.of(context).textTheme.overline,
                                textAlign: TextAlign.start,
                              ),
                            )
                          ],
                        ));
                  },
                );
              }).toList(),
              options: CarouselOptions(
                height: 200,
                //aspectRatio: 16 / 9,
                viewportFraction: 0.95,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 5),
                autoPlayAnimationDuration: Duration(milliseconds: 950),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                //onPageChanged: callbackFunction,
                scrollDirection: Axis.horizontal,
              )),
        ],
      ),
    );
  }
}

class TestimoniesParam {
  final String text;
  final String pic;

  const TestimoniesParam(this.text, this.pic);
}

const List<TestimoniesParam> data = const [
  TestimoniesParam(
      "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et.",
      "assets/logo/acer_icon_light.png"),
  TestimoniesParam(
      "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et.",
      "assets/logo/acer_icon_light.png"),
  TestimoniesParam(
      "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et.",
      "assets/logo/acer_icon_light.png"),
];
