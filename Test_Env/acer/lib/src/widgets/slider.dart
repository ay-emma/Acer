import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SliderAnim extends StatefulWidget {
  @override
  _SliderAnimState createState() => _SliderAnimState();
}

class _SliderAnimState extends State<SliderAnim> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
          items: [1, 2, 3, 4, 5].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(color: Colors.amber),
                  child: Image.network(
                    "https://static.vecteezy.com/system/resources/previews/000/180/360/non_2x/e-learning-vector-illustration.png",
                    fit: BoxFit.cover,
                  ),
                );
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
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            //onPageChanged: callbackFunction,
            scrollDirection: Axis.horizontal,
          )),
    );
  }
}
