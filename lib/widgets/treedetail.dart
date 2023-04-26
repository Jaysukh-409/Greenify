// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greenify_new/screens/landing_page.dart';

class TreeDetail extends StatelessWidget {
  String name;
  String description;
  String soil;
  TreeDetail(
      {Key? key,
      required this.name,
      required this.description,
      required this.soil})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   onPressed: ()=>Navigator.of(context).pop(),
        //   icon: Icon(Icons.arrow_back),
        // ),
        leading: GestureDetector(
          onTap: (() => Get.to(() => Home())),
          child: Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: Text(name),
      ),
      body: Column(
        children: [
          Container(
              height: 40,
              decoration: BoxDecoration(color: Colors.amberAccent),
              child: Center(
                  child: Text(
                "Description",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ))),
          SizedBox(height: 10),
          Text(
            description,
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 10),
          Container(
              height: 40,
              decoration: BoxDecoration(color: Colors.amberAccent),
              child: Center(
                  child: Text(
                "Soil Need",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ))),
          SizedBox(height: 10),
          Text(
            soil,
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
