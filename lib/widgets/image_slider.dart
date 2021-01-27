import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageSlider extends StatelessWidget {

  final List images;
  ImageSlider({this.images});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: images.length,
      itemBuilder: (BuildContext context, int itemIndex) => Container(
        width: double.infinity,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0),
            child: CachedNetworkImage(
              imageUrl: images[itemIndex],
              placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fadeInCurve: Curves.easeIn,
              fadeOutDuration: Duration(milliseconds: 1000),
              fit: BoxFit.cover,
              height: 400,
            ),),
      ),
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * 0.45,
        aspectRatio: 16 / 9,
        viewportFraction: 1,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.easeInOut,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
