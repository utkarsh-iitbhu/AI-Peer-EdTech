// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class LearningCard extends StatefulWidget {
  const LearningCard({
    Key? key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.complete,
    required this.total,
  }) : super(key: key);

  final String image;
  final String title;
  final String subtitle;
  final int complete;
  final int total;

  @override
  State<LearningCard> createState() => _LearningCardState();
}

class _LearningCardState extends State<LearningCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 20, 10, 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 0.7, color: Colors.black)),
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
                Spacer(),
                Icon(
                  Icons.play_circle_outlined,
                  color: Color(0xff4C7EFF),
                  size: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.edit,
                  color: Color(0xff4C7EFF),
                  size: 30,
                )
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
    );
  }
}
