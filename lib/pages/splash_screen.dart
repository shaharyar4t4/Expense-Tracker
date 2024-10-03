
import 'dart:async';
import 'package:expense_tracker/constant/consta.dart';
import 'package:expense_tracker/pages/HomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class splash_screen extends StatefulWidget{
  @override
  State<splash_screen> createState() => _splash_screenState();

}


class _splash_screenState extends State<splash_screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 1), () {

      // this code specific for Replace the page and not show the splash screen
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Homepage(),
          ));

    });
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: tdBGcolor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(21),
                  image: DecorationImage(
                    image: AssetImage('assets/images/logo.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}