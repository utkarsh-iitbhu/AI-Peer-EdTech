// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecentCard extends StatefulWidget {
  const RecentCard({
    Key? key,
    required this.image,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String image;
  final String title;
  final String subtitle;

  @override
  State<RecentCard> createState() => _RecentCardState();
}

class _RecentCardState extends State<RecentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: EdgeInsets.fromLTRB(0, 20, 10, 0),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black12,
          spreadRadius: 0,
          blurRadius: 8,
          offset: const Offset(1, 0.01),
        )
      ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(
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
                    textStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
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
            width: 70,
          ),
          Icon(
            Icons.play_circle_outlined,
            size: 46,
            color: Color(0xff4C7EFF),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}
