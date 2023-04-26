// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: w / 2,
                padding: EdgeInsets.only(left: 10, right: 10),
                height: h * 0.3,
                color: Colors.deepOrange,
                child: Center(
                  child: Text(
                    "Someone is sitting in shade today because someone planted a tree long time ago.",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900]),
                  ),
                ),
              ),
              Container(
                width: w / 2,
                padding: EdgeInsets.only(left: 10, right: 10),
                height: h * 0.3,
                color: Colors.deepOrange,
                child: Center(
                  child: Text(
                    "If I thought I was going to die tomorrow, I should nevertheless plant a tree today.",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900]),
                  ),
                ),
              ),
            ],
          ),
          Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              height: h * 0.3,
              color: Colors.white,
              child: Center(
                child: Text(
                  "Until you dig a hole, you plant a tree, you water it and make it survive, you haven't done a thing. You are just talking.",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.purpleAccent),
                ),
              )),
          Row(
            children: [
              Container(
                width: w / 2,
                padding: EdgeInsets.only(left: 10, right: 10),
                height: h * 0.3,
                color: Colors.green,
                child: Center(
                  child: Text(
                    "Trees are poems that earth writes upon the sky, we fell them down and turn them into paper, That we may record our emptiness.",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellowAccent),
                  ),
                ),
              ),
              Container(
                width: w / 2,
                padding: EdgeInsets.only(left: 10, right: 10),
                height: h * 0.3,
                color: Colors.green,
                child: Center(
                  child: Text(
                    "The care of the Earth is our most ancient and most worthy, and after all, our most pleasing responsibility.",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellowAccent),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
