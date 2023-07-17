// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inter_iit/Cards/premiumCard.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      child: Image(
                        image: AssetImage('assets/avatar.png'),
                        height: 90,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Akanksha Verma',
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600)),
                        ),
                        Text(
                          'NEET Student',
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  fontSize: 17,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                    Spacer(),
                    Icon(
                      Icons.edit,
                      color: Colors.grey,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                PremiumCard(),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(14),
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Progress Report',
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(fontSize: 17)),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            'My Plans',
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(fontSize: 17)),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            'Language',
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(fontSize: 17)),
                          ),
                          Spacer(),
                          Text(
                            'English',
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(fontSize: 17)),
                          ),
                          SizedBox(
                            width: 14,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            'Refer',
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(fontSize: 17)),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            'Rate App',
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(fontSize: 17)),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Share',
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(fontSize: 17)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Log Out',
                        style: GoogleFonts.lato(
                            textStyle:
                                TextStyle(fontSize: 17, color: Colors.red)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
