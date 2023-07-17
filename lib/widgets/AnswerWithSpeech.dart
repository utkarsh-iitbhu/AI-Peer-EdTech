import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speech_to_text/speech_to_text.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:http/http.dart' as http;
class AnswerWithSpeech extends StatefulWidget {
  final String answer;
  const AnswerWithSpeech({super.key, required this.answer});

  @override
  State<AnswerWithSpeech> createState() => _AnswerWithSpeechState();
}

class _AnswerWithSpeechState extends State<AnswerWithSpeech> {
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  double _similarityScore = -1;
  bool _isListening = false;

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
    getSimilarity();
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
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }
  Future<double> getSimilarity() async {
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
      "text1": "Microscopic anatomy is concerned with the study of structural units small enough to be seen only with a light microscope.",
      "text2": _lastWords,
      "similarity": "null"
    });
    final response = await http.post(
        Uri.parse('http://34.93.7.10:8000/similarity/create/'),
        body: strings,
        headers: headers);
    final Map<String, dynamic> data = jsonDecode(response.body);
    
    String x = data['similarity'];
    

    double y  = double.parse(x.split(" ")[6].split("%")[0]);
    print("Y = " + y.toString());
    setState(() {
      _similarityScore = y;
      similarity = data['similarity'];
    });
    return y;
  }

  String similarity = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: (() {
              if (_speechToText.isListening) {
                _stopListening();
              } else {
                _startListening();
              }
            }),
            child: AvatarGlow(
              endRadius: _isListening ? 75.0 : 30.0,
              glowColor: _isListening ? Colors.red : Colors.white,
              child: Material(
                // Replace this child with your own
                elevation: 0.0,
                shape: CircleBorder(),
                child: CircleAvatar(
                  backgroundColor:
                      _speechToText.isListening ? Colors.red : Colors.blue,
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
          Text(
              _lastWords != ""
                  ? _lastWords
                  : 'Explain the AI peer using the microphone',
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF41424F),
                ),
              )).py16(),
          (_lastWords == "")
              ? Container()
              : GestureDetector(
                  onTap: () {
                    setState(() {
                      _similarityScore = widget.answer.similarityTo(_lastWords);
                    });
                    print(_similarityScore);
                  },
                  child: (_lastWords != "")
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue
                                
                            // borderRadius: BorderRadius.circular(50),
                          ),
                          child: (_similarityScore == -1
                                  ? "Submit"
                                  : "Score: " + _similarityScore.toString() + "%")
                              .text
                              .white
                              .makeCentered()
                              .p16(),
                        ).p12()
                      : null,
                )
        ],
      ),
    );
  }
}
