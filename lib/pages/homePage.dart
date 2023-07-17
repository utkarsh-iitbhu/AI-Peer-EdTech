// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inter_iit/home.dart';
import 'package:inter_iit/pages/libraryPage.dart';
import 'package:inter_iit/pages/profilePage.dart';
import 'package:inter_iit/pages/progressPage.dart';
import '../Cards/flashcardPreview.dart';
import '../Cards/groupCard.dart';
import '../Cards/premiumCard.dart';
import '../Cards/progressCard.dart';
import '../Cards/recentCard.dart';
import 'groupsPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 0,
                      blurRadius: 8,
                      offset: Offset(1, 0.01),
                    )
                  ],
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              child: AppBar(
                toolbarHeight: MediaQuery.of(context).size.height * 0.09,
                backgroundColor: Colors.white,
                elevation: 0.4,
                title: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Row(
                    children: [
                      Text(
                        "Hello Akanksha!",
                        style: GoogleFonts.openSans(
                            textStyle: const TextStyle(
                                color: Color(0xFF41424F),
                                fontWeight: FontWeight.w700,
                                fontSize: 25)),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfilePage()));
                        },
                        child: CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.white,
                          child: Image(
                              image: AssetImage(
                            'assets/avatar.png',
                          )),
                        ),
                      )
                    ],
                  ),
                ),
                automaticallyImplyLeading: false,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Progress Dashboard',
                  style: GoogleFonts.openSans(
                      textStyle:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProgressPage())),
                  child: Center(
                    child: Text(
                      'See All',
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Color(0xFFABABAB),
                              fontWeight: FontWeight.w600,
                              fontSize: 15)),
                    ),
                  ),
                )
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    ProgressCard(
                      image: 'assets/progress.png',
                      title: 'Evolution of Humans',
                      subtitle: 'Biology',
                      complete: 30,
                      total: 42,
                      color: Colors.green,
                    ),
                    ProgressCard(
                      image: 'assets/progress.png',
                      title: 'Atoms and Molecules',
                      subtitle: 'Chemistry',
                      complete: 20,
                      total: 40,
                      color: Colors.yellow,
                    ),
                    ProgressCard(
                      image: 'assets/progress.png',
                      title: 'Anatomy',
                      subtitle: 'Biology',
                      complete: 12,
                      total: 60,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Text(
                  'Your Recent Reads',
                  style: GoogleFonts.lato(
                      textStyle:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen(pageIndex: 3)));
                  },
                  child: Center(
                    child: Text(
                      'See All',
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Color(0xFFABABAB),
                              fontWeight: FontWeight.w600,
                              fontSize: 15)),
                    ),
                  ),
                )
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    RecentCard(
                      image: 'assets/progress.png',
                      title: 'Evolution of Humans',
                      subtitle: 'Biology'
                    ),
                    RecentCard(
                      image: 'assets/progress.png',
                      title: 'Electricity',
                      subtitle: 'Physics',
                    ),
                    RecentCard(
                      image: 'assets/progress.png',
                      title: 'Isomers',
                      subtitle: 'Chemistry',
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            PremiumCard(),
            SizedBox(
              height: 24,
            ),
            Text(
              'Flashcards just for you!',
              style: GoogleFonts.lato(
                  textStyle:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    FlashcardPreview(
                      image: 'assets/stats.png',
                      title: 'Zoology',
                      subtitle: '500+ flashcards',
                    ),
                    FlashcardPreview(
                      image: 'assets/stats.png',
                      title: 'Organic Chemistry',
                      subtitle: '200+ flashcards',
                    ),
                    FlashcardPreview(
                      image: 'assets/stats.png',
                      title: 'Microbiology',
                      subtitle: '700+ flashcards',
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Learning together',
                  style: GoogleFonts.lato(
                      textStyle:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GroupsPage())),
                  child: Center(
                    child: Text(
                      'See All',
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Color(0xFFABABAB),
                              fontWeight: FontWeight.w600,
                              fontSize: 15)),
                    ),
                  ),
                )
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    GroupCard(
                      images: ['assets/avatar.png', 'assets/avatar2.png'],
                      title: 'Chill Studss',
                    ),
                    GroupCard(
                      images: ['assets/avatar.png', 'assets/avatar2.png'],
                      title: 'Gargi + Ayush',
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 25,
            )
          ],
        ),
      ),
    );
  }
}
