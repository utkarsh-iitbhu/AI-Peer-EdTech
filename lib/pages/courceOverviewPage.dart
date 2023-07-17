// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:velocity_x/velocity_x.dart';

import 'flashcardsPage.dart';

class CourseOverview extends StatefulWidget {
  final imageUrl;
  final title;
  final description;
  final complete;
  final total;
  final color;
  final bgColor;
  const CourseOverview(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.description,
      required this.complete,
      required this.total,
      required this.color,
      required this.bgColor});

  @override
  State<CourseOverview> createState() => _CourseOverviewState();
}

class _CourseOverviewState extends State<CourseOverview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.bgColor,
      body: SafeArea(
        child: Stack(alignment: Alignment.center, children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomPaint(
                painter: CurvePainter(widget.color),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                ),
              )
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.90,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ),
                      "Back".text.black.size(20).make(),
                    ],
                  ).pOnly(left: 30, bottom: 10),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    "Lets".text.black.size(25).make(),
                    "Continue".text.bold.white.size(25).make().px(5),
                    "With".text.black.size(25).make(),
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.70,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: CourseOverviewCard(
                    imageUrl: "assets/CourseOverviewImg.png",
                    title: widget.title,
                    subtitle:
                        widget.description,
                    complete: 70,
                  ),
                ),
                Card(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => FlashcardsPage(title: widget.title, color: widget.color, bgcolor: widget.bgColor,)));
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          height: 50,
                          child: Center(
                            child: "Continue Learning"
                                .text
                                .white
                                .size(20)
                                .center
                                .make(),
                          )),
                    )).pOnly(top: 10)
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  final Color color;
  CurvePainter(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    // TODO: Set properties to paint
    paint.color = color;
    paint.style = PaintingStyle.fill;
    var path = Path();

    // TODO: Draw your path
    path.moveTo(0, size.height * 0.3167);
    path.quadraticBezierTo(size.width * 0.05, size.height * 0.295,
        size.width * 0.1, size.height * 0.3167);
    path.quadraticBezierTo(size.width * 0.45, size.height * 0.4584,
        size.width * 0.9, size.height * 0.3167);
    path.quadraticBezierTo(size.width * 0.95, size.height * 0.295, size.width,
        size.height * 0.3167);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class CourseOverviewCard extends StatefulWidget {
  final complete;
  final String title;
  final String subtitle;
  final imageUrl;

  const CourseOverviewCard(
      {super.key,
      required this.complete,
      required this.title,
      required this.imageUrl,
      required this.subtitle});

  @override
  State<CourseOverviewCard> createState() => _CourseOverviewCardState();
}

class _CourseOverviewCardState extends State<CourseOverviewCard> {
  bool isBookMarked = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: ShapeBorder.lerp(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          1),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.80,
                child: Image(
                  image: AssetImage(widget.imageUrl),
                  fit: BoxFit.fitWidth,
                ).pOnly(top: 40),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (widget.title).text.size(30).bold.make(),
                      "Course Time: 10-15 Minutes"
                          .text
                          .size(8)
                          .caption(context)
                          .make(),
                      "170+ Cards".text.size(15).make().pOnly(top: 10)
                    ],
                  ).pOnly(left: 20),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isBookMarked = !isBookMarked;
                      });
                    },
                    child: Icon(
                      (!isBookMarked) ? Icons.bookmark_border : Icons.bookmark,
                      size: 40,
                    ).pOnly(right: 20),
                  ),
                ],
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.90,
            child: widget.subtitle.text
                .size(15)
                .align(TextAlign.left)
                .maxLines(5)
                .make()
                .pOnly(left: 20, top: 10, right: 20),
          ),
          Row(
            children: [
              LinearPercentIndicator(
                barRadius: const Radius.circular(10),
                width: MediaQuery.of(context).size.width * 0.6,
                lineHeight: 6.0,
                backgroundColor: const Color(0xFFE5E5E5),
                progressColor: Colors.blue,
                animation: true,
                animationDuration: 1000,
                percent: widget.complete / 100,
              ).pOnly(left: 20, bottom: 50),
              (widget.complete.toString() + "%")
                  .text
                  .size(15)
                  .align(TextAlign.left)
                  .make()
                  .pOnly(left: 20, bottom: 50),
            ],
          ),
        ],
      )),
    );
  }
}
