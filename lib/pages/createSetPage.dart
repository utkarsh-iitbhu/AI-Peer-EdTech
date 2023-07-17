//ignore_for_file: prefer_const_constructors
// import 'dart:html';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tesseract_ocr/android_ios.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inter_iit/pages/createPage.dart';
import 'package:pdf_text/pdf_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as p;

class CreateSetPage extends StatefulWidget {
  const CreateSetPage({Key? key}) : super(key: key);

  @override
  State<CreateSetPage> createState() => _CreateSetPageState();
}

class _CreateSetPageState extends State<CreateSetPage> {
  bool loading = false;
  // List<File> files = [];
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController textController = TextEditingController();
  TextEditingController topicController = TextEditingController();

  Future<File> chooseFiles() async {
    setState(() {
      loading = true;
    });
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      PDFDoc doc = await PDFDoc.fromFile(file);
      String docText = await doc.text;
      final prefs = await SharedPreferences.getInstance();
      print(p.basename(file.path));
      print(docText);
      print(titleController.text);
      await prefs.setString(
          '${titleController.text}/${topicController.text}', docText);
      List<String> folders = prefs.getStringList('foldersList') ?? [];
      folders.add(titleController.text);
      await prefs.setStringList('foldersList', folders);
      setState(() {
        loading = false;
      });
      Navigator.pop(context);
      return file;
    } else {
      return File('');
    }
  }

  Future scanImage() async {
    setState(() {
      loading = true;
    });
    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    print(photo!.path);
    String text = await FlutterTesseractOcr.extractText(photo!.path, args: {
      "psm": "4",
      "preserve_interword_spaces": "1",
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        '${titleController.text}/${topicController.text}', text);
    List<String> folders = prefs.getStringList('foldersList') ?? [];
    folders.add(titleController.text);
    await prefs.setStringList('foldersList', folders);
    setState(() {
      loading = false;
    });
    Navigator.pop(context);
  }

  Future saveText() async {
    setState(() {
      loading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    print(topicController.text);
    print(textController.text);
    await prefs.setString(
        '${titleController.text}/${topicController.text}', textController.text);
    List<String> folders = prefs.getStringList('foldersList') ?? [];
    folders.add(titleController.text);
    await prefs.setStringList('foldersList', folders);
    setState(() {
      loading = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Create Set',
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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 20),
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 0.7),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Choose Cover\n(Optional)',
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16)),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Title',
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 14),
                            ),
                            controller: titleController,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Description (Optional)',
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 14),
                            ),
                            controller: descController,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Private',
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Upload Files',
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                loading
                    ? Center(child: CircularProgressIndicator())
                    : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: TextField(
                              controller: topicController,
                              decoration: InputDecoration(
                                  hintText: 'Enter a topic',
                                  hintStyle: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16)),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.black)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.black))),
                            ),
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: () async {
                                chooseFiles();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 0.7, color: Colors.grey)),
                                width: MediaQuery.of(context).size.width * 0.8,
                                height:
                                    MediaQuery.of(context).size.height * 0.075,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.upload,
                                        color: Colors.grey,
                                      ),
                                      Text(
                                        'Tap to upload a PDF',
                                        style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                scanImage();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 0.7, color: Colors.grey)),
                                width: MediaQuery.of(context).size.width * 0.8,
                                height:
                                    MediaQuery.of(context).size.height * 0.075,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.camera,
                                        color: Colors.grey,
                                      ),
                                      Text(
                                        'Tap to scan any image',
                                        style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                TextField(
                                  autofocus: false,
                                  controller: textController,
                                  decoration: InputDecoration(
                                      hintText: 'Text',
                                      hintStyle: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16)),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.black)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.black))),
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 4,
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Center(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(13),
                                      ),
                                      primary: Color(0xff4C7EFF),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text(
                                        'Continue',
                                        style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17)),
                                      ),
                                    ),
                                    onPressed: () async {
                                      if (titleController.text.isNotEmpty &&
                                          textController.text.isNotEmpty &&
                                          topicController.text.isNotEmpty) {
                                        saveText();
                                      }
                                    },
                                  ),
                                  // Container(
                                  //   height: 150.0,
                                  //   width: double.infinity,
                                  //   color: Colors.white,
                                  //   child: GestureDetector(
                                  //     onTap: () async {
                                  //       if (titleController.text.isNotEmpty &&
                                  //           textController.text.isNotEmpty &&
                                  //           topicController.text.isNotEmpty) {
                                  //         saveText();
                                  //       }
                                  //     },
                                  //     child: Center(
                                  //       child: Padding(
                                  //         padding: EdgeInsets.symmetric(
                                  //             vertical: 10.0),
                                  //         child: Container(
                                  //           padding: EdgeInsets.all(16),
                                  //           decoration: BoxDecoration(
                                  //             border: Border.all(
                                  //                 color: Color(0xff4C7EFF)),
                                  //             borderRadius:
                                  //                 BorderRadius.circular(13),
                                  //           ),
                                  //           child: Text(
                                  //             'Continue',
                                  //             style: GoogleFonts.lato(
                                  //                 textStyle: TextStyle(
                                  //                     color: Color(0xff4C7EFF),
                                  //                     fontWeight:
                                  //                         FontWeight.w600,
                                  //                     fontSize: 18)),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                )
                              ],
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
