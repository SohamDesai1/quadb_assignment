import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MovieCard extends StatelessWidget {
  final String desc;
  final String image;
  final String name;
  const MovieCard(
      {super.key, required this.desc, required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30.w,
      height: 21.h,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5), topRight: Radius.circular(5)),
          border: Border.all(color: Colors.black),
          color: Colors.white),
      child: Column(
        children: [
          Image.network(
            image,
            width: 30.w,
            height: 13.h,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
          Text(
            name,
            style: const TextStyle(fontSize: 14),
          ),
          SizedBox(
            height: 0.3.h,
          ),
          Center(
            child: Container(
              color: Colors.amber,
              width: 50.w,
              height: 5.h,
              child: Text(
                desc,
                style: const TextStyle(fontSize: 10.5),
              ),
            ),
          )
        ],
      ),
    );
  }
}
