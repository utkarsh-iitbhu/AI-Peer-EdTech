// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CollectionCard extends StatefulWidget {
  const CollectionCard({
    Key? key,
    required this.image,
    required this.title,
    required this.color,
  }) : super(key: key);

  final String image;
  final String title;
  final Color color;

  @override
  State<CollectionCard> createState() => _CollectionCardState();
}

class _CollectionCardState extends State<CollectionCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.19,
      width: MediaQuery.of(context).size.width * 0.4,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.fromLTRB(0, 20, 10, 0),
      decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 0.7, color: Colors.black)),
      child: Column(
        children: [
          Image(
            image: AssetImage(widget.image),
          ),
          Spacer(),
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
