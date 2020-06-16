import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreditCards extends StatefulWidget {
  CreditCards({
    Key key,
  }) : super(key: key);

  @override
  _CreditCardsState createState() => _CreditCardsState();
}

class _CreditCardsState extends State<CreditCards> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          child: CardSlider(
            height: MediaQuery.of(context).size.height * 0.7,
          ),
        ),
      ),
    );
  }
}

class CardSlider extends StatefulWidget {
  final double height;
  CardSlider({Key key, this.height}) : super(key: key);

  @override
  _CardSliderState createState() => _CardSliderState();
}

class _CardSliderState extends State<CardSlider> {
  double positionY_line1;
  double positionY_line2;
  List<CardInfo> _cardInfoList;

  @override
  void initState() {
    super.initState();
    positionY_line1 = widget.height * 0.1;
    positionY_line2 = positionY_line1 + 200;

    _cardInfoList = [
      CardInfo(
        userName: "GABRIEL CHAVES",
        leftColor: Color.fromARGB(255, 234, 94, 190),
        rightColor: Color.fromARGB(255, 224, 63, 92),
      ),
      CardInfo(
        userName: "GABRIEL CHAVES",
        leftColor: Color.fromARGB(255, 171, 51, 75),
        rightColor: Color.fromARGB(255, 171, 51, 75),
      ),
      CardInfo(
        userName: "GABRIEL CHAVES",
        leftColor: Color.fromARGB(255, 10, 10, 10),
        rightColor: Color.fromARGB(255, 10, 10, 10),
      ),
      CardInfo(
        userName: "GABRIEL CHAVES",
        leftColor: Color.fromARGB(255, 85, 137, 234),
        rightColor: Color.fromARGB(255, 85, 137, 234),
      ),
    ];

    for (var i = 0; i < _cardInfoList.length; i++) {
      CardInfo cardInfo = _cardInfoList[i];

      if (i == 0) {
        cardInfo.positionY = positionY_line1;
        cardInfo.opacity = 1.0;
        cardInfo.scale = 1.0;
        cardInfo.rotate = 1.0;
      } else {
        cardInfo.positionY = positionY_line2+(i-1)*30;
        cardInfo.opacity = 0.7-(i-1)*0.1;
        cardInfo.scale = 0.9;
        cardInfo.rotate = -60;
      }
    }

    _cardInfoList = _cardInfoList.reversed.toList();
  }

  _buildCards() {
    List widgetList = [];

    _cardInfoList.forEach((cardInfo) {
      widgetList.add(Positioned(
        top: cardInfo.positionY,
        child: Transform(
          alignment: Alignment.topCenter,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(pi / 180 * cardInfo.rotate)
            ..scale(cardInfo.scale),
          child: Opacity(
            opacity: cardInfo.opacity,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(
                  color: Colors.black.withOpacity(0.3), blurRadius: 10,
                  offset: Offset(0,5)
                )],
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.red,
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        cardInfo.leftColor,
                        cardInfo.rightColor,
                      ])),
              width: 300,
              height: 190,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 120,
                    left: 20,
                    child: Text(
                      "2134",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 150,
                    left: 20,
                    child: Text(
                      cardInfo.userName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ));
    });

    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 230, 228, 232),
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  "YOUR SECURITY CREDIT CARD",
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Positioned(
              top: positionY_line1,
              child: Container(
                color: Colors.red,
                height: 1,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Positioned(
              top: positionY_line2,
              child: Container(
                color: Colors.red,
                height: 1,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            ..._buildCards(),
          ],
        ),
      ),
    );
  }
}

class CardInfo {
  Color leftColor;
  Color rightColor;
  String userName;
  String cardCategory;
  double positionY = 0;
  double rotate = 0;
  double opacity = 0;
  double scale = 1;
  CardInfo({
    this.leftColor,
    this.rightColor,
    this.userName,
    this.cardCategory,
    this.positionY,
    this.rotate,
    this.opacity,
    this.scale,
  });
}
