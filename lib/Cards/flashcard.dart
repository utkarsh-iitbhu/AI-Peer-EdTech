// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../pages/courceOverviewPage.dart';

class Flashcard extends StatefulWidget {
  const Flashcard({
    Key? key,
    required this.color,
    required this.bgcolor,
    required this.text, required this.bgimgUrl
  }) : super(key: key);

  final Color color;
  final Color bgcolor;
  final String text;
  final String bgimgUrl;

  @override
  State<Flashcard> createState() => _FlashcardState();
}

class _FlashcardState extends State<Flashcard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.5,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(widget.bgimgUrl),
          fit: BoxFit.fill
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.text,
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    )),
              ),
              SizedBox(height: 40,),
            ],
          ),
        ),
      ),
    );
  }
}
