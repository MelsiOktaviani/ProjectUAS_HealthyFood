import 'package:flutter/material.dart';

class AboutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF21BFBD),
        title: Text("About This App"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/food1.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "HEALTHY FOOD",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Container(
              padding: EdgeInsets.all(10),
              color: Colors.transparent,
              margin: EdgeInsets.symmetric(vertical: 50, horizontal: 10),
              child: Column(
                children: <Widget>[
                  Text(
                    "Life is like healthy food: you can add as much vegetable as you like but if you want it to be healthy, you’ve got to eat it. Unless you make a move, nothing happens. Stay Distance with Healthy Food and get your better Healthy Food with online order and amazing offer.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                    softWrap: true,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}