// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inter_iit/pages/profilePage.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:velocity_x/velocity_x.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage>
    with TickerProviderStateMixin {
  // late TabController _controller;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  List<List<String>> userData = [
    ['0', 'AI Reviews'],
    ['20', 'Weekly Hours'],
    ['5', 'Study Sets'],
    ['500', 'FlashCards'],
    ['20', 'Friends'],
    ['3', 'Study Groups'],
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage()));
                      },
                      child: CircleAvatar(
                        radius: 20,
                        child: Image(
                          image: AssetImage('assets/avatar.png'),
                          // height: 70,
                        ),
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
                                  fontSize: 18, fontWeight: FontWeight.w600)),
                        ),
                        Text(
                          'NEET Student',
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                    Spacer(),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xffECBC00)),
                          borderRadius: BorderRadius.circular(16)),
                      padding: EdgeInsets.all(6),
                      child: Row(
                        children: [
                          Icon(
                            Icons.electric_bolt,
                            color: Color(0xffECBC00),
                            size: 16,
                          ),
                          Text(
                            '16',
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Color(0xffF1F2F6),
                padding: EdgeInsets.all(5),
                child: GridView.count(
                  childAspectRatio: 3.5,
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  shrinkWrap: true,
                  children: List.generate(6, (index) {
                    return Container(
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 0.7),
                          borderRadius: BorderRadius.circular(2),
                          color: Colors.white),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            userData[index][0],
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600)),
                          ),
                          Text(
                            userData[index][1],
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    color: Color(0xff6A6A6A),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(
                height: 20,
              ),

              // TODO: Tabs
              DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TabBar(
                          indicator: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Color.fromARGB(99, 158, 158, 158),
                                  width: 1)),
                          labelColor: Colors.blue,
                          unselectedLabelColor: Colors.grey,
                          tabs: [
                            Tab(text: 'Statistics'),
                            Tab(text: 'Calendar'),
                          ]),
                    ).pOnly(bottom: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: TabBarView(children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              Center(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    'Weekly',
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 10),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xfff4f9ff)),
                                        borderRadius: BorderRadius.circular(6),
                                        color: Color(0xfff4f9ff),
                                      ),
                                      child: Column(
                                        children: [
                                          CircularPercentIndicator(
                                            backgroundColor: Color(0xffA1DCFF),
                                            progressColor: Color(0xff009EFA),
                                            animation: true,
                                            animationDuration: 1000,
                                            radius: 30,
                                            percent: 0.25,
                                            center: Text(
                                              '25%',
                                              style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 6,
                                          ),
                                          Text(
                                            'AI Feedback Level',
                                            style: GoogleFonts.lato(
                                                textStyle: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            '15',
                                            style: GoogleFonts.lato(
                                                textStyle: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ),
                                          Text(
                                            'AI Reviews',
                                            style: GoogleFonts.lato(
                                                textStyle: TextStyle(
                                                    color: Color(0xff6A6A6A),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            '13 mins',
                                            style: GoogleFonts.lato(
                                                textStyle: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ),
                                          Text(
                                            'Avg Review Session',
                                            style: GoogleFonts.lato(
                                                textStyle: TextStyle(
                                                    color: Color(0xff6A6A6A),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'AI Feedbacks',
                                            style: GoogleFonts.lato(
                                                textStyle: TextStyle(
                                                    color: Color(0xff6A6A6A),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ),
                                          Image(
                                            width: 150,
                                            image:
                                                AssetImage('assets/graph.png'),
                                            fit: BoxFit.fill,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  children: [
                                    Center(
                                      child: Text(
                                        'Sessions Analysis',
                                        style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 24,
                                    ),
                                    Image(
                                      image: AssetImage(
                                          'assets/sessionAnalysis.png'),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Column(children: [
                            Container(
                                child: TableCalendar(
                              firstDay: DateTime.utc(2010, 10, 16),
                              lastDay: DateTime.utc(2030, 3, 14),
                              focusedDay: DateTime.now(),
                              calendarFormat: CalendarFormat.month,
                              selectedDayPredicate: (day) =>
                                  isSameDay(_selectedDay, day), //new
                              onDaySelected: (selectedDay, focusedDay) {
                                if (!isSameDay(_selectedDay, selectedDay)) {
                                  // Call `setState()` when updating the selected day
                                  setState(() {
                                    _selectedDay = selectedDay;
                                    _focusedDay = focusedDay;
                                  });
                                }
                              },
                              headerStyle: HeaderStyle(
                                formatButtonVisible: false,
                                titleCentered: true,
                                titleTextStyle: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600)),
                                leftChevronIcon: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.black,
                                  size: 15,
                                ),
                                rightChevronIcon: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                  size: 15,
                                ),
                              ),
                              calendarStyle: CalendarStyle(
                                selectedDecoration: BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                ),
                                selectedTextStyle: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600)),
                                todayDecoration: BoxDecoration(
                                  color: Colors.blue.shade300,
                                  shape: BoxShape.circle,
                                ),
                                todayTextStyle: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600)),
                                outsideDaysVisible: false,
                              ),

                              onPageChanged: (focusedDay) {
                                // No need to call `setState()` here
                                _focusedDay = focusedDay;
                              },
                            )).p8(),
                            SizedBox(
                              height: 10,
                            ),
                            CalendarCard(
                              pDate: _focusedDay,
                            )
                          ]),
                        ),
                      ]),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              // TabBarView(children: [
              //   Container(child: Text("1"),),
              //   Container(child: Text("2"),),
              // ]),
              // DefaultTabController(length: 2,
              //   child: Scaffold(
              //     appBar: TabBar(
              //       labelColor: Colors.blue,
              //       unselectedLabelColor: Colors.grey,
              //       tabs: [
              //         Tab(text:'Calendar'),
              //         Tab(text:'Statistics'),
              //       ]
              //     ),
              //     ),
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}

class CalendarCard extends StatefulWidget {
  final DateTime pDate;
  const CalendarCard({super.key, required this.pDate});

  @override
  State<CalendarCard> createState() => _CalendarCardState();
}

class _CalendarCardState extends State<CalendarCard> {
  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  String getSuffix(String date) {
    if (date == '1' || date == '21' || date == '31') {
      return 'st';
    } else if (date == '2' || date == '22') {
      return 'nd';
    } else if (date == '3' || date == '23') {
      return 'rd';
    } else {
      return 'th';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: ShapeBorder.lerp(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        1,
      ),
      child: Container(
        height: 176,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  "${widget.pDate.day}${getSuffix(widget.pDate.day.toString())} ${months[widget.pDate.month - 1]}, ${widget.pDate.year}"
                      .text
                      .bold
                      .size(15)
                      .make(),
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.blue,
                        ),
                      ),
                      height: 50,
                      // width: 100,
                      child: Center(
                        child: Text(
                          'Add Event + ',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ).p8(),
                      ))
                ],
              ).p8(),
              DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TabBar(
                          labelColor: Colors.blue,
                          unselectedLabelColor: Colors.grey,
                          indicator: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey.shade200,
                              width: 5,
                            ),
                          ),
                          tabs: const [
                            Tab(
                              text: 'Classes',
                            ),
                            Tab(text: 'Tests'),
                            Tab(text: 'Tasks'),
                          ]),
                    ),
                    Container(
                      height: 100,
                      child: TabBarView(
                        children: [
                          CalendarList(
                            list: const [
                              "Physics",
                              "Chemistry",
                              "Maths",
                            ],
                          ),
                          CalendarList(
                            list: [],
                          ),
                          CalendarList(
                            list: [],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ).p8(),
    );
  }
}

class CalendarList extends StatefulWidget {
  final List<String> list;
  CalendarList({super.key, required this.list});
  @override
  State<CalendarList> createState() => _CalendarListState();
}

class _CalendarListState extends State<CalendarList> {
  @override
  Widget build(BuildContext context) {
    return widget.list.length == 0
        ? Center(
            child: Container(
              height: 150,
              child: Image(
                image: AssetImage('assets/NoTasks.png'),
                fit: BoxFit.fill,
              ),
            ),
          )
        : ListView.builder(
            itemCount: widget.list.length,
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                title: Row(
                  children: [
                    Icon(
                      Icons.circle,
                      color: Colors.blue,
                      size: 10,
                    ).pOnly(right: 10),
                    Text(
                      widget.list[index],
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Color(0xFF09101D),
                              fontWeight: FontWeight.w400,
                              fontSize: 14)),
                    ),
                  ],
                ),
              );
            },
          );
  }
}
