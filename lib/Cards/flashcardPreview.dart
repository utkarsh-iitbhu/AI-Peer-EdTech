// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FlashcardPreview extends StatefulWidget {
  const FlashcardPreview({
    Key? key,
    required this.image,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String image;
  final String title;
  final String subtitle;

  @override
  State<FlashcardPreview> createState() => _FlashcardPreviewState();
}

class _FlashcardPreviewState extends State<FlashcardPreview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
      margin: EdgeInsets.fromLTRB(0, 20, 10, 0),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 0,
              blurRadius: 8,
              offset: const Offset(1, 0.01),
            )
          ],
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Image(image: AssetImage(widget.image)),
          SizedBox(
            height: 20,
          ),
          Text(
            widget.title,
            style: GoogleFonts.lato(
                textStyle:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            widget.subtitle,
            style: GoogleFonts.lato(
                textStyle: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600)),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              padding: EdgeInsets.all(7),
              width: 180,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text('View',
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.blue,
                            fontWeight: FontWeight.w600))),
              ))
        ],
      ),
    );
  }
}
