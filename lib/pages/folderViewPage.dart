// ignore_for_file: prefer_const_constructors
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tesseract_ocr/android_ios.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf_text/pdf_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

class FolderViewPage extends StatefulWidget {
  const FolderViewPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<FolderViewPage> createState() => _FolderViewPageState();
}

class _FolderViewPageState extends State<FolderViewPage> {
  bool loading = false;

  TextEditingController textController = TextEditingController();
  TextEditingController topicController = TextEditingController();

  Future<List<String>> getFolderFiles() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> allKeys = prefs.getKeys().toList();
    print(allKeys);
    List<String> folderFiles = allKeys
        .where((element) => element.contains('${widget.title}/'))
        .toList();
    print(folderFiles);
    return folderFiles;
  }

  Future chooseNewFile() async {
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
      await prefs.setString('${widget.title}/${topicController.text}', docText);
      setState(() {
        loading = false;
      });
    }
  }

  Future scanNewImage() async {
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
    await prefs.setString('${widget.title}/${topicController.text}', text);
    setState(() {
      loading = false;
    });
  }

  Future saveNewText() async {
    setState(() {
      loading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    print(topicController.text);
    print(textController.text);
    await prefs.setString(
        '${widget.title}/${topicController.text}', textController.text);
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFolderFiles();
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
                  fontSize: 20)),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
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
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Available Material',
                style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18)),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                child: FutureBuilder(
                  future: getFolderFiles(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        List<String> folderFiles = snapshot.data!;
                        return loading
                            ? Center(child: CircularProgressIndicator())
                            : ListView.builder(
                                itemCount: folderFiles.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.all(8),
                                    child: ListTile(
                                      leading: const Icon(Icons.list),
                                      title: Text(folderFiles[index]),
                                    ),
                                  );
                                },
                              );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: TextField(
                  controller: topicController,
                  decoration: InputDecoration(
                      hintText: 'Add a new topic',
                      hintStyle: GoogleFonts.lato(
                          textStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 16)),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.black))),
                ),
              ),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    chooseNewFile();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 0.7, color: Colors.grey)),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 65,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.upload,
                            color: Colors.grey,
                          ),
                          Text(
                            'Upload a new PDF',
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
                    scanNewImage();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 0.7, color: Colors.grey)),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 65,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.camera,
                            color: Colors.grey,
                          ),
                          Text(
                            'Scan a new image',
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
                      controller: textController,
                      decoration: InputDecoration(
                          hintText: 'Add new text',
                          hintStyle: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16)),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black))),
                      keyboardType: TextInputType.multiline,
                      maxLines: 4,
                    ),
                  ],
                ),
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
                  if (textController.text.isNotEmpty &&
                      topicController.text.isNotEmpty) {
                    saveNewText();
                  }
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
