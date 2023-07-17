// ignore_for_file: prefer_const_constructors
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PremiumCard extends StatefulWidget {
  const PremiumCard({Key? key}) : super(key: key);

  @override
  State<PremiumCard> createState() => _PremiumCardState();
}

class _PremiumCardState extends State<PremiumCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 0.6),
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xff07121A),
      ),
      child: Stack(children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          margin: const EdgeInsets.fromLTRB(0, 20, 10, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Go Elite',
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff1189F9)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  AnimatedTextKit(
                    repeatForever: true,
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Custom Flashcards',
                        textStyle: GoogleFonts.lato(
                          textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color(0xffffffff)),
                        ),
                        speed: const Duration(milliseconds: 100),
                      ),
                      TypewriterAnimatedText(
                        'In Depth AI Feedback',
                        textStyle: GoogleFonts.lato(
                          textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color(0xffffffff)),
                        ),
                        speed: const Duration(milliseconds: 100),
                      ),
                      TypewriterAnimatedText(
                        'Community Learning',
                        textStyle: GoogleFonts.lato(
                          textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color(0xffffffff)),
                        ),
                        speed: const Duration(milliseconds: 100),
                      ),
                    ],
                    onTap: () {
                      print("Tap Event");
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.8,
                    child: Text(
                      'Enjoy thorough AI analysis, live collaborative learning sessions with friends and many more premium features ...',
                      style: GoogleFonts.lato(
                        textStyle:
                            TextStyle(fontSize: 12, color: Color(0xffa5a3a3)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Container(
                      padding: EdgeInsets.all(6),
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 36,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff1189F9)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          'Become Elite Now',
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontSize: 14, color: Color(0xffCAE3FF)),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Spacer(),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Image(
            image: AssetImage('assets/globe.gif'),
            height: 125,
            width: 125,
          ),
        )
      ]),
    );
  }
}
