// ignore_for_file: prefer_const_constructors
import 'dart:async';
import 'dart:convert';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inter_iit/home.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

import '../widgets/AnswerWithSpeech.dart';

typedef void IntCallback(int id);

class AIPeerPage extends StatefulWidget {
  const AIPeerPage({Key? key}) : super(key: key);

  @override
  State<AIPeerPage> createState() => _AIPeerPageState();
}

class _AIPeerPageState extends State<AIPeerPage> {
  String similarity = "";
  String _selectedString = "";
  int _currentQue = 1;
  int _totalQue = 4;
  List<String> subs = [
    'Evolution of Humans',
    'Anatomy',
    'Zoology',
    'Modern Architecture',
    'Basics of Finance',
  ];

  PageController controller = PageController();
  final List<String> questions = [
    'What is “Microscopic anatomy”?',
    'Examples of people in the medical field who require a knowledge of anatomy.',
    'What is the study of large body structures  examined without the help of magnifying devices',
    'Comparative Anatomy compares _________ body structures in different species of animals ',
  ];

  String curr_sub = 'Evolution of Humans';
  bool continued = false;
  bool isQuestionStarts = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppBar(
                  backgroundColor: Colors.white,
                  title: Text(
                    'AI Peer${(_selectedString == "") ? "" : " > " + _selectedString}',
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 20)),
                  ),
                  centerTitle: (_selectedString == "") ? true : false,
                  elevation: 0,
                ),
                Row(
                  mainAxisAlignment: (_selectedString == "")
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Image(
                        height: (_selectedString == "")
                            ? MediaQuery.of(context).size.height * 0.33
                            : MediaQuery.of(context).size.height * 0.2,
                        image: AssetImage('assets/aipeer.gif'),
                      ),
                    ),
                    (_selectedString == "")
                        ? Container()
                        : Column(
                            children: [
                              "Great!".text.medium.size(24).make().p4(),
                              "Lets Begin".text.size(20).make(),
                              (isQuestionStarts == true)
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Row(
                                        children: [
                                          "${(_currentQue)}/${(_totalQue)}"
                                              .text
                                              .size(20)
                                              .bold
                                              .color(Colors.blue)
                                              .make()
                                        ],
                                      ),
                                    )
                                  : Container()
                            ],
                          ).p32()
                  ],
                ),
                // SizedBox(
                //   height: 10,
                // ),
                (_selectedString == "")
                    ? Text(
                        'Hello there!',
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 24)),
                      )
                    : Container(),
                SizedBox(
                  height: 8,
                ),
                (_selectedString == "")
                    ? Text(
                        'So good to see you!',
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 20)),
                      )
                    : Container(),
                SizedBox(
                  height: 20,
                ),
                continued
                    ? ExplainMeTheTopic(
                        questions: questions,
                        funToIncCurrQue: (int a) {
                          setState(() {
                            _currentQue = a;
                          });
                        },
                        funToContinue: () {
                          setState(() {
                            isQuestionStarts = true;
                          });
                        })
                    : Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Color(0xFFEBE5E5),
                                borderRadius: BorderRadius.circular(4)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40.0),
                              child: DropdownButton(
                                underline: SizedBox(),
                                style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 17)),
                                value: curr_sub,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: subs.map((String sub) {
                                  return DropdownMenuItem(
                                    value: sub,
                                    child: Text(sub),
                                  );
                                }).toList(),
                                onChanged: (String? newVal) {
                                  setState(() {
                                    curr_sub = newVal!;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                continued = true;
                                _selectedString = curr_sub;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xff4C7EFF)),
                                borderRadius: BorderRadius.circular(13),
                              ),
                              child: Text(
                                'Continue',
                                style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                        color: Color(0xff4C7EFF),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18)),
                              ),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ExplainMeTheTopic extends StatefulWidget {
  final List<String> questions;
  // final Function<int> funToIncCurrQue;
  final IntCallback funToIncCurrQue;
  final VoidCallback funToContinue;
  const ExplainMeTheTopic(
      {super.key,
      required this.questions,
      required this.funToIncCurrQue,
      required this.funToContinue});

  @override
  State<ExplainMeTheTopic> createState() => _ExplainMeTheTopicState();
}

class _ExplainMeTheTopicState extends State<ExplainMeTheTopic> {
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  double _similarityScore = -1;
  bool _isListening = false;
  bool continued = false;

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {
      _similarityScore = -1;
      _isListening = true;
    });
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {
      _isListening = false;
    });
    if (_lastWords.toLowerCase().contains("explain")) {
      widget.funToContinue();
      setState(() {
        continued = true;
      });
    }
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  bool tapped = false;
  PageController controller = PageController();
  int _currentQue = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: (continued == false)
          ? Column(
              children: [
                GestureDetector(
                  onTap: (() {
                    setState(() {
                      tapped = true;
                    });
                    if (_speechToText.isListening) {
                      _stopListening();
                    } else {
                      _startListening();
                    }
                  }),
                  child: AvatarGlow(
                    endRadius: 80,
                    glowColor: _isListening ? Colors.red : Colors.white,
                    child: Material(
                      // Replace this child with your own
                      elevation: 0.0,
                      shape: CircleBorder(),
                      child: CircleAvatar(
                        backgroundColor: _speechToText.isListening
                            ? Colors.red
                            : Colors.blue,
                        child: const Icon(
                          Icons.mic,
                          size: 40.0,
                          color: Colors.white,
                        ),
                        radius: 30.0,
                      ),
                    ),
                  ),
                ),
                Text(_lastWords != "" ? _lastWords : 'Explain me the Topic',
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF41424F),
                      ),
                    )).py16(),
                tapped
                    ? Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Color(0xff4C7EFF),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Center(
                          child:
                              "Continue".text.size(20).white.make().onTap(() {
                            _stopListening();
                            setState(() {
                              continued = true;
                            });
                            widget.funToContinue;
                          }),
                        ),
                      )
                    : Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Color(0xff4C7EFF),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Center(
                          child: "Skip".text.size(20).white.make(),
                        ),
                      ).onTap(() {
                        setState(() {
                          continued = true;
                        });
                        widget.funToContinue;
                      }),
              ],
            )
          : Container(
              height: MediaQuery.of(context).size.height * 0.55,
              child: PageView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                controller: controller,
                children: [
                  for (int i = 0; i < widget.questions.length; i++)
                    Center(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                        child: ListView(
                          children: [
                            Container(
                              height: 100,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(0xff4C7EFF), width: 2),
                                borderRadius: BorderRadius.circular(13),
                              ),
                              child: Center(
                                child: Text(
                                  widget.questions[i],
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18)),
                                ).p20(),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            AnsweringWidget(
                              answerwidgetType: i,
                            )
                          ],
                        ),
                      ),
                    )
                ],
                onPageChanged: (num) {
                  setState(() {
                    _currentQue = num + 1;
                    widget.funToIncCurrQue(_currentQue);
                  });
                },
              ),
            ),
    );
  }
}

// class TestSection extends StatefulWidget {
//   const TestSection({Key? key}) : super(key: key);

//   @override
//   State<TestSection> createState() => _TestSectionState();
// }

// class _TestSectionState extends State<TestSection> {

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override

//   int curr = 0;

//   @override
//   Widget build(BuildContext context) {

//     return
//   }
// }

class AnsweringWidget extends StatefulWidget {
  final int answerwidgetType;
  const AnsweringWidget({super.key, required this.answerwidgetType});

  @override
  State<AnsweringWidget> createState() => _AnsweringWidgetState();
}

class _AnsweringWidgetState extends State<AnsweringWidget> {
  int _selectedOption = -1;
  final List<Widget> answerWidgets = [
    // ElevatedButton(
    //   style: ElevatedButton.styleFrom(
    //     shape: CircleBorder(),
    //   ),
    //   child: Padding(
    //     padding: const EdgeInsets.all(10.0),
    //     child: Icon(
    //       recorder.isRecording ? Icons.stop : Icons.mic,
    //       size: 50,
    //     ),
    //   ),
    //   onPressed: () async {
    //     if (recorder.isRecording) {
    //       await stop();
    //     } else {
    //       await record();
    //     }
    //     setState(() {});
    //   },
    // ),
    AnswerWithSpeech(
      answer: "Hello",
    ),
    TypeTheAnswer(),
    AnswerWithOption(),
    FillInTheBlanks()
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.40,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Center(child: answerWidgets[widget.answerwidgetType]),
    );
  }
}

class TypeTheAnswer extends StatefulWidget {
  const TypeTheAnswer({super.key});

  @override
  State<TypeTheAnswer> createState() => _TypeTheAnswerState();
}

class _TypeTheAnswerState extends State<TypeTheAnswer> {
  final myController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  var connecting;

  bool show = false;
  Future? myFuture;
  String similarity = "";
  double _similarityScore = -1;
  Future<double> getSimilarity(String s) async {
    // var resp = await http.post(Uri.parse('http://34.93.7.10:8000/similarity/create'),body: jsonEncode({
    //   "text1": _lastWords,
    //   "text2": widget.answer,
    // }
    // ),
    // headers: {'Content-Type': 'application/json'}
    // );
    // print("DATA IS ${resp.body}");
    Map<String, String> headers = {'Content-Type': 'application/json'};
    final strings = jsonEncode({
      "text1":
          "Paramedics, nurses, physical therapists, occupational therapists, medical doctors, prosthetists",
      "text2": s,
      "similarity": "null"
    });
    final response = await http.post(
        Uri.parse('http://34.93.7.10:8000/similarity/create/'),
        body: strings,
        headers: headers);
    final Map<String, dynamic> data = jsonDecode(response.body);

    String x = data['similarity'];

    double y = double.parse(x.split(" ")[6].split("%")[0]);
    print("Y = " + y.toString());
    setState(() {
      _similarityScore = y;
      similarity = data['similarity'];
    });
    return y;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            controller: myController,
            keyboardType: TextInputType.multiline,
            maxLines: 5,
            minLines: 5,
            decoration: InputDecoration(
              constraints: BoxConstraints(
                maxHeight: 150,
              ),
              hintText: 'Type the answer',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
                borderSide: BorderSide(
                  color: Color(0xff4C7EFF),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13),
            ),
            primary: Color(0xff4C7EFF),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 15),
            child: (show == false)
                ? Text(
                    'Submit',
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 17)),
                  )
                :
                // : Text(
                //     "${_similarityScore}% Correct",
                //     style: GoogleFonts.lato(
                //         textStyle: TextStyle(
                //             color: Colors.white,
                //             fontWeight: FontWeight.w500,
                //             fontSize: 17)),
                //   ),
                Center(
                    child: FutureBuilder(
                      future: connecting,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                snapshot.error.toString(),
                                textAlign: TextAlign.center,
                                textScaleFactor: 1.3,
                              ),
                            );
                          }

                          return Text(
                            "${_similarityScore}% Correct",
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17)),
                          );
                        }
                        // By default, show a loading spinner
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ),
          ),
          onPressed: () {
            getSimilarity(myController.text);
            Future.delayed(Duration(seconds: 0), () {
              setState(() {
                show = true;
                connecting = getSimilarity(myController.text);
              });
            });
          },
        ),
      ],
    );
  }
}

class FillInTheBlanks extends StatefulWidget {
  const FillInTheBlanks({super.key});

  @override
  State<FillInTheBlanks> createState() => _FillInTheBlanksState();
}

class _FillInTheBlanksState extends State<FillInTheBlanks> {
  Color color = Color(0xff4C7EFF);
  final myController = TextEditingController();
  String _submitedStr = "";
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  bool end = false;
  @override
  Widget build(BuildContext context) {
    return end
        ? Center(child: Image(image: AssetImage('assets/done.gif')))
        : Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 16),
                child: Text(
                  'Fill in the blanks to answer the question',
                  style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 18)),
                ),
              ),
              TextField(
                controller: myController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Answer',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                    borderSide: BorderSide(
                      color: Color(0xff4C7EFF),
                    ),
                  ),
                ),
              ).p16(),
              // Padding(
              //   padding: const EdgeInsets.only(top: 48.0),
              //   child: ElevatedButton(
              //     style: ElevatedButton.styleFrom(
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(13),
              //       ), backgroundColor: color,
              //     ),
              //     child: Padding(
              //       padding: const EdgeInsets.symmetric(
              //           horizontal: 40.0, vertical: 15),
              //       child: Text(
              //         'Submit',
              //         style: GoogleFonts.lato(
              //             textStyle: TextStyle(
              //                 color: Colors.white,
              //                 fontWeight: FontWeight.w500,
              //                 fontSize: 17)),
              //       ),
              //     ),
              //     onPressed: () {
              //       print(myController.text);
              //       if (myController.text.toLowerCase() == 'similar') {
              //         setState(() {
              //           color = Colors.green;
              //         });
              //       } else {
              //         setState(() {
              //           color = Colors.red;
              //         });
              //       }
              //       Timer(Duration(seconds: 3), () {
              //         setState(() {
              //           end = true;
              //         });
              //         Timer(Duration(seconds: 3), () {
              //           Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                   builder: (context) =>
              //                       HomeScreen(pageIndex: 1)));
              //         });
              //       });
              //     },
              //   ),
              // ),
              Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                        color:
                            (_submitedStr.toLowerCase().removeAllWhiteSpace() ==
                                    "similar")
                                ? Colors.green
                                : (_submitedStr == "")
                                    ? Colors.blue
                                    : Colors.red,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Center(child: "Submit".text.white.make()))
                  .onTap(() {
                print(myController.text);
                setState(() {
                  _submitedStr = myController.text;
                });
                Timer(Duration(seconds: 3), () {
                  setState(() {
                    end = true;
                  });
                  Timer(Duration(seconds: 3), () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeScreen(pageIndex: 1)));
                  });
                });
              })
            ],
          );
  }
}

class AnswerWithOption extends StatefulWidget {
  const AnswerWithOption({super.key});

  @override
  State<AnswerWithOption> createState() => _AnswerWithOptionState();
}

class _AnswerWithOptionState extends State<AnswerWithOption> {
  bool end = false;
  int _selectedOption = -1;
  int _correctOption = 1;
  bool _submitted = false;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text(
          'Answer the Question with the help of options',
          style: GoogleFonts.lato(
              textStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 18)),
        ),
        SizedBox(
          height: 4,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedOption = 0;
            });
          },
          child: Container(
            width: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                    .size
                    .width *
                0.8,
            decoration: BoxDecoration(
              color: (_selectedOption == 0 && !_submitted)
                  ? Color.fromARGB(171, 33, 149, 243)
                  : (_submitted && _selectedOption == 0)
                      ? (_selectedOption == _correctOption)
                          ? Colors.green
                          : Colors.red
                      : Colors.grey[200],
              borderRadius: BorderRadius.circular(13),
            ),
            child: "Virology".text.make().p20(),
          ).p8(),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedOption = 1;
            });
          },
          child: Container(
            width: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                    .size
                    .width *
                0.8,
            decoration: BoxDecoration(
              color: (_selectedOption == 1 && !_submitted)
                  ? Color.fromARGB(171, 33, 149, 243)
                  : (_submitted && _selectedOption == 1)
                      ? (_selectedOption == _correctOption)
                          ? Colors.green
                          : Colors.red
                      : Colors.grey[200],
              borderRadius: BorderRadius.circular(13),
            ),
            child: "Gross Anatomy".text.make().p20(),
          ).p8(),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedOption = 2;
            });
          },
          child: Container(
            width: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                    .size
                    .width *
                0.8,
            decoration: BoxDecoration(
              color: (_selectedOption == 2 && !_submitted)
                  ? Color.fromARGB(171, 33, 149, 243)
                  : (_submitted && _selectedOption == 2)
                      ? (_selectedOption == _correctOption)
                          ? Colors.green
                          : Colors.red
                      : Colors.grey[200],
              borderRadius: BorderRadius.circular(13),
            ),
            child: "Zoology".text.make().p20(),
          ).p8(),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13),
            ),
            primary: Color(0xff4C7EFF),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              'Submit',
              style: GoogleFonts.lato(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 17)),
            ),
          ),
          onPressed: () {
            setState(() {
              _submitted = true;
              end = true;
            });
          },
        ),
      ],
    );
  }
}
