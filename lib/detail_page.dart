import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


class DetailPage extends StatefulWidget {
  final String mname;
  final String desc;
  final String status;
  final String image;
  final String type;
  const DetailPage({
    super.key,
    required this.mname,
    required this.desc,
    required this.status,
    required this.image,
    required this.type,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Movie Details"),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 4.h,
            ),
            Row(
              children: [
                Image.network(widget.image,
                    width: 40.w, height: 35.h, fit: BoxFit.cover),
                Padding(
                  padding: EdgeInsets.only(bottom: 20.h, left: 15.w),
                  child: Column(
                    children: [
                      Text(
                        widget.mname,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Text(
                        "Status:    ${widget.status}",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Text(
                        "Type:      ${widget.type}",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 4.h,
            ),
            SizedBox(
                width: 95.w,
                child: Text(
                  widget.desc,
                  style: const TextStyle(fontSize: 16),
                ))
          ],
        ),
      ),
    );
  }
}
