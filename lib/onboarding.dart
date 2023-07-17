import 'package:flutter/material.dart';
import 'package:inter_iit/home.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

List<Color> onboardingColor = [
  Color(0xFFC4F2F4),
  Color(0xFFA68BDF),
  Color(0xFFFEDCB6),
  Color(0xFF4C7EFF)
];

Future<String> getOption() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('optionChosen') ?? 'No Data';
}

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 4;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? onboardingColor[_currentPage] : Color(0xFFEBEBEB),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              _currentPage != _numPages - 1
                  ? Container(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () => {
                          _pageController.jumpToPage(_numPages - 1),
                          setState(() {
                            _currentPage = _numPages - 1;
                          })
                        },
                        child: Visibility(
                          visible: _currentPage != _numPages - 1,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text('Skip',
                                style: GoogleFonts.urbanist(
                                  textStyle: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF41424F),
                                  ),
                                )),
                          ),
                        ),
                      ),
                    )
                  : Container(),
              Container(
                height: screenSize.height * 0.7,
                child: PageView(
                  physics: ClampingScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: <Widget>[
                    onboardingPage(
                      screenSize: screenSize,
                      image: 'assets/onb1.png',
                      title: 'Enhance Retention',
                      desc:
                          'Automatic well organized flashcard generated from your notes',
                    ),
                    onboardingPage(
                      screenSize: screenSize,
                      image: 'assets/onb2.png',
                      title: 'Teach and Learn',
                      desc:
                          'Teach your AI peer and get helpful insights just like a friend',
                    ),
                    onboardingPage(
                      screenSize: screenSize,
                      image: 'assets/onb3.png',
                      title: 'Progress Tracking',
                      desc:
                          'Well curated AI-generated tests and regular progress tracking',
                    ),
                    optionsPage(
                        screenSize: screenSize,
                        image: 'assets/options.png',
                        title: 'What brings you here?',
                        subtitle: 'Choose one option for now',
                        options: [
                          'Explore Study Materials',
                          'Create own flashcards',
                          'Prepare for exams',
                          'Just look around',
                        ])
                  ],
                ),
              ),

              Visibility(
                visible: _currentPage != _numPages - 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildPageIndicator(),
                  ),
                ),
              ),
              // Visibility(
              //   visible: _currentPage != _numPages - 1,
              //   child: Expanded(
              //     child: Align(
              //       alignment: FractionalOffset.bottomRight,
              //       child: TextButton(
              //         onPressed: () {
              //           _pageController.nextPage(
              //             duration: Duration(milliseconds: 500),
              //             curve: Curves.ease,
              //           );
              //         },
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           mainAxisSize: MainAxisSize.min,
              //           children: <Widget>[
              //             Text(
              //               'Next',
              //               style: TextStyle(
              //                 color: onboardingColor[_currentPage],
              //                 fontSize: 22.0,
              //               ),
              //             ),
              //             SizedBox(width: 10.0),
              //             Icon(
              //               Icons.arrow_forward,
              //               color: Colors.white,
              //               size: 30.0,
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(height: 10.0)
            ],
          ),
        ),
      ),
      bottomSheet: Visibility(
        visible: true,
        child: Container(
          height: 150.0,
          width: double.infinity,
          color: Colors.white,
          child: GestureDetector(
            onTap: () async {
              var prefs = await SharedPreferences.getInstance();
              prefs.setBool('is_onboarded', true);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => HomeScreen(pageIndex: 0,)));
            },
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                      color: onboardingColor[_currentPage],
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: Text('Get Started',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.urbanist(
                          textStyle: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF41424F),
                          ),
                        )),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class onboardingPage extends StatelessWidget {
  const onboardingPage({
    Key? key,
    required this.screenSize,
    required this.image,
    required this.title,
    required this.desc,
  }) : super(key: key);

  final Size screenSize;
  final String image;
  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Image(
                image: AssetImage(
                  image,
                ),
                height: 300,
                width: 300,
              ),
            ),
            SizedBox(height: screenSize.height * 0.025),
            Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.urbanist(
                  textStyle: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF41424F),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenSize.height * 0.05),
            Text(
              desc,
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF41424F),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class optionsPage extends StatefulWidget {
  const optionsPage(
      {Key? key,
      required this.screenSize,
      required this.image,
      required this.title,
      required this.subtitle,
      required this.options})
      : super(key: key);

  final Size screenSize;
  final String image;
  final String title;
  final String subtitle;
  final List<String> options;

  @override
  State<optionsPage> createState() => _optionsPageState();
}

class _optionsPageState extends State<optionsPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getOption(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An Error Occurred'),
            );
          } else if (snapshot.hasData) {
            final data = snapshot.data as String;
            if (data == 'No Data') {
              return Scaffold(
                backgroundColor: Colors.white,
                appBar: null,
                body: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: widget.screenSize.height * 0.30,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/loading_back.png'),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Center(
                              child: Image(
                                height: widget.screenSize.height * 0.21,
                                image: AssetImage('assets/loading_logo.gif'),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            widget.title,
                            style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w800,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          widget.subtitle,
                          style: const TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          height: widget.screenSize.height * 0.03,
                        ),
                        for (int i = 0; i < widget.options.length; i++)
                          InkWell(
                            onTap: () async {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString(
                                  'optionChosen', widget.options[i]);
                              setState(() {});
                            },
                            child: Container(
                              margin: const EdgeInsets.all(6),
                              width: widget.screenSize.width * 0.7,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xffCFD0DA)),
                                  borderRadius: BorderRadius.circular(36)),
                              padding: const EdgeInsets.all(13),
                              child: Center(
                                  child: Text(
                                widget.options[i],
                                style: GoogleFonts.lato(
                                    textStyle: const TextStyle(
                                  fontSize: 18,
                                )),
                              )),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: widget.screenSize.height * 0.30,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/loading_back.png'),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Center(
                          child: Image(
                            height: widget.screenSize.height * 0.21,
                            image: AssetImage('assets/loading_logo.gif'),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 24.0, horizontal: 50),
                      child: Text(
                        "Finding the best activities to help you learn...",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF41424F),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(6),
                      width: widget.screenSize.width * 0.67,
                      padding: const EdgeInsets.all(8),
                      child: Center(
                          child: Row(
                        children: [
                          const Icon(
                            Icons.done_outline_sharp,
                            size: 15,
                            color: Colors.green,
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Text(
                            'Personalising your learning \nand retention',
                            style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                              fontSize: 15,
                            )),
                          ),
                        ],
                      )),
                    ),
                    Container(
                      margin: const EdgeInsets.all(6),
                      width: widget.screenSize.width * 0.67,
                      padding: const EdgeInsets.all(8),
                      child: Center(
                          child: Row(
                        children: [
                          const Icon(
                            Icons.done_outline_sharp,
                            size: 15,
                            color: Colors.green,
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Text(
                            'Creating your super optimal \nflashcards',
                            style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                              fontSize: 15,
                            )),
                          ),
                        ],
                      )),
                    ),
                    Container(
                      margin: const EdgeInsets.all(6),
                      width: widget.screenSize.width * 0.67,
                      padding: const EdgeInsets.all(8),
                      child: Center(
                          child: Row(
                        children: [
                          const Icon(
                            Icons.done_outline_sharp,
                            size: 15,
                            color: Colors.green,
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Text(
                            'Preparing AI to ease your \nstudies...',
                            style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                              fontSize: 15,
                            )),
                          ),
                        ],
                      )),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    LinearPercentIndicator(
                      barRadius: const Radius.circular(10),
                      alignment: MainAxisAlignment.center,
                      width: widget.screenSize.width * 0.7,
                      lineHeight: 14.0,
                      percent: 1,
                      backgroundColor: const Color(0xFFE5E5E5),
                      progressColor: Colors.blue,
                      animation: true,
                      animationDuration: 3000,
                    ),
                  ],
                ),
              );
            }
          }
        }
        return const Center(
          child: Text('Error'),
        );
      },
    );
  }
}
