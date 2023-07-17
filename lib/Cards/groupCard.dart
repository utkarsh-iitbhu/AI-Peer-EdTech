// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GroupCard extends StatefulWidget {
  const GroupCard({
    Key? key,
    required this.images,
    required this.title,
  }) : super(key: key);

  final List<String> images;
  final String title;

  @override
  State<GroupCard> createState() => _GroupCardState();
}

class _GroupCardState extends State<GroupCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.65,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      margin: EdgeInsets.fromLTRB(0, 20, 10, 0),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black12,
          spreadRadius: 0,
          blurRadius: 8,
          offset: const Offset(1, 0.01),
        )
      ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Stack(
              children: [
                Positioned(
                  child: CircleAvatar(
                    radius: 20,
                    child: Image(
                      image: AssetImage(widget.images[0]),
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  child: CircleAvatar(
                    // backgroundColor: Colors.red,
                    radius: 20,
                    child: Image(
                      image: AssetImage(widget.images[1]),
                    ),
                  ),
                ),
                Positioned(
                  left: 40,
                  child: CircleAvatar(
                    backgroundColor: Color(0XFFD4E8FF),
                    radius: 20,
                    child: Center(
                      child: Text('+8'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Continue your streak on',
            style: GoogleFonts.lato(
                textStyle: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600)),
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            widget.title,
            style: GoogleFonts.lato(
                textStyle:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
