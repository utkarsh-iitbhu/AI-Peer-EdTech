// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inter_iit/pages/createSetPage.dart';
import 'package:inter_iit/pages/flashcardsPage.dart';
import 'package:inter_iit/pages/folderViewPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Cards/folderCard.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getKeys();
  }

  Future<void> reload() async {
    setState(() {});
  }

  void getKeys() async {
    final prefs = await SharedPreferences.getInstance();
    print(prefs.get('foldersList'));
  }

  Future<List> getFolders() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> folders = prefs.getStringList('foldersList') ?? [];
    List foldersData = [];
    for (int i = 0; i < folders.length; i++) {
      foldersData.add({
        'image': 'assets/folder.png',
        'title': folders[i],
        'date': '12th Nov 2022',
        'color': Color(0xff6CBEB6),
        'private': false,
      });
    }
    return foldersData;
  }

  // List folders = [
  //   {
  //     'image': 'assets/folder.png',
  //     'title': 'Anatomy',
  //     'date': '12th Nov 2022',
  //     'color': Color(0xff6CBEB6),
  //     'private': false,
  //   },
  //   {
  //     'image': 'assets/folder.png',
  //     'title': 'Anatomy',
  //     'date': '12th Nov 2022',
  //     'color': Color(0xff6CBEB6),
  //     'private': false,
  //   },
  // ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  'Create Study Set',
                  style: GoogleFonts.lato(
                      textStyle:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 26)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateSetPage()))
                      .then((value) => setState(() {}));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xff4C7EFF)),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Text(
                      'Create New +',
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              color: Color(0xff4C7EFF),
                              fontWeight: FontWeight.w500,
                              fontSize: 17)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: getFolders(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      List folders = snapshot.data!;
                      return GridView.count(
                        physics: BouncingScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        shrinkWrap: true,
                        children: List.generate(folders.length, (index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FlashcardsPage(
                                            title: folders[index]['title'],
                                            color: Colors.black,
                                            bgcolor: Colors.white,
                                          )));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: FolderCard(
                                reload: reload,
                                image: folders[index]['image'],
                                title: folders[index]['title'],
                                date: folders[index]['date'],
                                color: folders[index]['color'],
                                private: folders[index]['private'],
                              ),
                            ),
                          );
                        }),
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
