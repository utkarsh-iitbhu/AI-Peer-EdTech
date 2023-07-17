//ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

import '../Cards/groupDetailsCard.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({Key? key}) : super(key: key);

  @override
  State<GroupsPage> createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {

  List friendsList = [
    {
      'image': 'assets/avatar.png',
      'name': 'Astha',
      'sharedDecks': 0,
    },
    {
      'image': 'assets/avatar.png',
      'name': 'Astha',
      'sharedDecks': 0,
    },
    {
      'image': 'assets/avatar.png',
      'name': 'Astha',
      'sharedDecks': 0,
    },
    {
      'image': 'assets/avatar.png',
      'name': 'Astha',
      'sharedDecks': 0,
    },
    {
      'image': 'assets/avatar.png',
      'name': 'Astha',
      'sharedDecks': 0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Learn together',
          style: GoogleFonts.lato(
              textStyle:
              TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18)),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Center(
            child: Text(
              'Back',
              style: GoogleFonts.lato(
                  textStyle:
                  TextStyle(color: Color(0xff4C7EFF),fontWeight: FontWeight.w600, fontSize: 18)),
            ),
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: TextFormField(
                  focusNode: FocusNode(),
                  // scribbleEnabled: false,
                  autofocus: false,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search,color: Colors.grey[800],),
                  ),
                  onEditingComplete: () {
                    print("Search\n\n");
                  },
                ),
              ),
            ),
            SizedBox(height: 10,),
            GroupDetailsCard(
              images: const [
                'assets/avatar.png',
                'assets/avatar2.png',
                'assets/avatar3.png',
              ],
              title: 'Chilll Studds',
              streak: 16,
            ),
            SizedBox(height: 10,),
            GroupDetailsCard(
              images: const [
                'assets/avatar.png',
                'assets/avatar2.png',
                'assets/avatar3.png',
              ],
              title: 'Gargi + Ayush',
              streak: 8,
            ),
            SizedBox(height: 10,),
            Text(
              'Friends List',
              style: GoogleFonts.lato(
                  textStyle:
                  TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            ),
            SizedBox(height: 15,),
          ],
        ),
      ),
    );
  }
}
