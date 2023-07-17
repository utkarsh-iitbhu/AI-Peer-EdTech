// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inter_iit/pages/courceOverviewPage.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProgressCard extends StatefulWidget {
  const ProgressCard({
    Key? key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.complete,
    required this.total,
    required this.color,
  }) : super(key: key);

  final String image;
  final String title;
  final String subtitle;
  final int complete;
  final int total;
  final Color color;

  @override
  State<ProgressCard> createState() => _ProgressCardState();
}

class _ProgressCardState extends State<ProgressCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CourseOverview(
                      color: Color.fromARGB(255, 97, 205, 255),
                      title: widget.title,
                      description: widget.subtitle,
                      imageUrl: widget.image,
                      complete: widget.complete,
                      total: widget.total,
                      bgColor: Color.fromARGB(255, 255, 160, 220),
                    )));
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 20, 10, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 0,
              blurRadius: 8,
              offset: const Offset(1, 0.01),
            )
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image(
                    image: AssetImage(widget.image),
                    height: 60,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.title,
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                      ),
                      Text(
                        widget.subtitle,
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                                fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  '${widget.complete}/${widget.total} Completed',
                  style: GoogleFonts.lato(
                      textStyle:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              LinearPercentIndicator(
                barRadius: const Radius.circular(10),
                alignment: MainAxisAlignment.center,
                width: MediaQuery.of(context).size.width * 0.7,
                lineHeight: 6.0,
                backgroundColor: const Color(0xFFE5E5E5),
                progressColor: Colors.blue,
                animation: true,
                animationDuration: 1000,
                percent: widget.complete / widget.total,
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
