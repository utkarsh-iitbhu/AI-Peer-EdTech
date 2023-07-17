//ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inter_iit/pages/folderViewPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FolderCard extends StatefulWidget {
  const FolderCard({
    Key? key,
    required this.image,
    required this.title,
    required this.date,
    required this.color,
    required this.private,
    required this.reload,
  }) : super(key: key);

  final String image;
  final String title;
  final String date;
  final Color color;
  final bool private;
  final Function reload;

  @override
  State<FolderCard> createState() => _FolderCardState();
}

class _FolderCardState extends State<FolderCard> {

  String dropdownValue = '';

  void customize(String folderName) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => FolderViewPage(title: folderName)));
  }

  List dropdownItems = [
    'Customize',
    'Invite Friends',
    'Rename',
    'Visibility',
    'Delete',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 35, 0, 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1.4, color: widget.color)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Image(image: AssetImage(widget.image),)),
          Spacer(),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w600)),
                  ),
                  Text(
                    widget.date,
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
              Spacer(),
              PopupMenuButton(
                itemBuilder: (context) => [
                  for(int i = 0; i < dropdownItems.length; i++)
                    PopupMenuItem(
                      value: i+1,
                      child: GestureDetector(
                        onTap: () async {
                          if (dropdownItems[i] == 'Customize') {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => FolderViewPage(title: widget.title)));
                          }
                          else if (dropdownItems[i] == 'Rename') {

                          }
                          else if (dropdownItems[i] == 'Delete') {
                            final prefs = await SharedPreferences.getInstance();
                            List<String> folders = prefs.getStringList('foldersList') ?? [];
                            folders.remove(widget.title);
                            await prefs.setStringList('foldersList', folders);
                            List<String> allKeys = prefs.getKeys().toList();
                            List<String> toBeRemoved = allKeys.where((element) => element.contains('${widget.title}/')).toList();
                            print(toBeRemoved);
                            for (String tbr in toBeRemoved) {
                              prefs.remove(tbr);
                            }
                            FocusScope.of(context).requestFocus(FocusNode());
                            widget.reload();
                          }
                        },
                        child: Text(dropdownItems[i]),
                      ),
                    )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
