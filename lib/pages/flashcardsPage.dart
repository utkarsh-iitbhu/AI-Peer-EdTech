//ignore_for_file: prefer_const_constructors
import 'dart:convert';

import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inter_iit/Cards/flashcard.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FlashcardsPage extends StatefulWidget {
  const FlashcardsPage({
    Key? key,
    required this.title,
    required this.color,
    required this.bgcolor,
  }) : super(key: key);

  final String title;
  final Color color;
  final Color bgcolor;

  @override
  State<FlashcardsPage> createState() => _FlashcardsPageState();
}

class _FlashcardsPageState extends State<FlashcardsPage> {
  List <String> flashcardsTexts = [
    "Anatomy, a field in the biological sciences concerned with the identification and description of the body structures of living things.",
    "“Gross anatomy” customarily refers to the study of those body structures large enough to be examined without the help of magnifying devices",
    "Microscopic anatomy is concerned with the study of structural units small enough to be seen only with a light microscope.",
    "Comparative Anatomy, the other major subdivision of the field, compares similar body structures in different species of animals in order to understand the adaptive changes they have undergone in the course of evolution.",
    "Paramedics, nurses, physical therapists, occupational therapists, medical doctors, prosthetists, and biological scientists all need a knowledge of anatomy.",
    "Name the field in the biological sciences concerned with the identification and description of the body structures of living things.",
    "What is the study of large body structures  examined without the help of magnifying devices?",
    "Microscopic anatomy is concerned with the _________ small enough to be seen only with a light microscope.",
    "Microscopic anatomy is concerned with the _________ small enough to be seen only with a light microscope.",
    "Comparative Anatomy, the other major subdivision of the field, compares similar body structures in different species of animals in order to understand the adaptive changes they have undergone in the _______________ of evolution.",
    "Examples of people in the medical field who require a knowledge of anatomy",

  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFlashcardData();
  }

  bool done = false;

  Future<List<String>> getFlashcardData() async {
    Map<String,String> headers = {'Content-Type': 'application/json'};
    final prefs = await SharedPreferences.getInstance();
    List<String> allKeys = prefs.getKeys().toList();
    List<String> folderFiles = allKeys.where((element) => element.contains('${widget.title}/')).toList();
    String allText = "";
    for (int i = 0; i < folderFiles.length; i++) {
      allText += prefs.getString(folderFiles[i]) ?? "";
    }
    print(allText);
    final msg = jsonEncode({
      "text": allText
    });
    final response = await http.post(Uri.parse('http://34.93.7.10:8000/summary/create/'), body: msg, headers: headers);
    final Map<String, dynamic> data = jsonDecode(response.body);
    print(data['flashcards']);
    return json.decode(data['flashcards']).cast<String>().toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.title,
          style: GoogleFonts.lato(
              textStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18)),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Center(
            child: Text(
              'Back',
              style: GoogleFonts.lato(
                  textStyle: TextStyle(
                      color: Color(0xff4C7EFF),
                      fontWeight: FontWeight.w600,
                      fontSize: 18)),
            ),
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Almost there 251/300',
              style: GoogleFonts.lato(
                  textStyle: TextStyle(
                      color: Color(0xff41424F),
                      fontWeight: FontWeight.w400,
                      fontSize: 14)),
            ),
            SizedBox(
              height: 10,
            ),
            LinearPercentIndicator(
              barRadius: const Radius.circular(10),
              lineHeight: 6.0,
              backgroundColor: const Color(0xFFE5E5E5),
              progressColor: Colors.blue,
              // animation: true,
              // animationDuration: 1000,
              percent: 251 / 300,
            ),
            Container(
                height: MediaQuery.of(context).size.height * 0.6,
                child: FutureBuilder(
                  future: getFlashcardData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        List<String> data = (widget.title=="Anatomy") ? flashcardsTexts :snapshot.data!.reversed.toList();
                        return done ? Center(child: Image(image: AssetImage('assets/done.gif'))) : AppinioSwiper(
                          cards: [
                            for (int i = 0; i < data.length; i++)
                              Flashcard(color: Colors.black, bgcolor: Colors.white, text: data[i],bgimgUrl:(widget.title=="Anatomy") ? 'assets/anatomyBg.png' :'assets/flashbg.png',)
                          ],
                          onEnd: () async {
                            setState(() {
                              done = true;
                            });
                            await Future.delayed(const Duration(seconds: 5));
                            Navigator.pop(context);
                          },
                        );
                      }
                      return Center(child: Text('Oops! An error occurred :('));
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                )),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.7, color: Color(0xff26A545)),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Text(
                        'Too Easy',
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                color: Color(0xff26A545),
                                fontWeight: FontWeight.w400,
                                fontSize: 14)),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.timer,
                            size: 12,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            'in 3 days',
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.7, color: Color(0xff628EFF)),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Text(
                        'Good',
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                color: Color(0xff628EFF),
                                fontWeight: FontWeight.w400,
                                fontSize: 14)),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.timer,
                            size: 12,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            'at the end',
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.7, color: Color(0xffFF0808)),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Text(
                        'Too hard',
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                color: Color(0xffFF0808),
                                fontWeight: FontWeight.w400,
                                fontSize: 14)),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.timer,
                            size: 12,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            'in 4 cards',
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12)),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
