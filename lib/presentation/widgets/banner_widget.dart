// ignore_for_file: sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.only(top:3.0,left: 3,right: 3,bottom: 5),
      child: ImageSlideshow(
        width: double.infinity,
        height: 400,
        initialPage: 0,
        indicatorRadius: 5,
        indicatorColor: Colors.blue,
        indicatorBackgroundColor: Colors.grey,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.asset(
              "assets/images/bread.png",
              fit: BoxFit.cover,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.asset(
              "assets/images/drinks.png",
              fit: BoxFit.cover,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.asset(
              "assets/images/coffee.png",
              fit: BoxFit.cover,
            ),
          ),
        ],
        autoPlayInterval: 3000,
        isLoop: true,
      ),
    );
  }
}
