//ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GroupDetailsCard extends StatefulWidget {
  const GroupDetailsCard({
    Key? key,
    required this.images,
    required this.title,
    required this.streak
  }) : super(key: key);

  final List<String> images;
  final String title;
  final int streak;

  @override
  State<GroupDetailsCard> createState() => _GroupDetailsCardState();
}

class _GroupDetailsCardState extends State<GroupDetailsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      // margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 0.6),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Row(
            children: [
              for (int i = 0; i < widget.images.length; i++)
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      child: Image(
                        image: AssetImage(widget.images[i]),
                      ),
                    ),
                    SizedBox(width: 20,)
                  ],
                ),
              CircleAvatar(
                radius: 20,
                backgroundColor: Color(0xffD4E8FF),
                child: Center(
                  child: Text('+7'),
                ),
              )
            ],
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Continue your streak on',
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600)),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    widget.title,
                    style: GoogleFonts.lato(
                        textStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Color(0xffFFFBEC),
                  border: Border.all(color: Color(0xffECBC00), width: 0.7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(Icons.electric_bolt, color: Color(0xffECBC00), size: 16,),
                    Text(' ${widget.streak}')
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
