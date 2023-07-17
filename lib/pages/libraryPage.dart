// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';
import '../Cards/collectionCard.dart';
import '../Cards/learningCard.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  final _kTabs = <Tab>[
    const Tab(text: 'Personal Library'),
    const Tab(text: 'Shared Library'),
  ];
  final _kTabPages = <Widget>[
    const PersonalLib(),
    const CommunityLib(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: DefaultTabController(
            length: _kTabs.length,
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.black,
                    tabs: _kTabs,
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: _kTabPages,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

class PersonalLib extends StatefulWidget {
  const PersonalLib({super.key});

  @override
  State<PersonalLib> createState() => _PersonalLibState();
}

class _PersonalLibState extends State<PersonalLib> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            'Currently Learning',
            style: GoogleFonts.lato(
                textStyle:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LearningCard(
              image: 'assets/anatomy.png',
              title: 'Anatomy',
              subtitle: 'Lorem Ipsum',
              complete: 30,
              total: 42,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LearningCard(
              image: 'assets/zoology.png',
              title: 'Zoology',
              subtitle: 'Lorem Ipsum',
              complete: 30,
              total: 42,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LearningCard(
              image: 'assets/progress.png',
              title: 'Evolution',
              subtitle: 'Lorem Ipsum',
              complete: 30,
              total: 42,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                'Your Collection',
                style: GoogleFonts.lato(
                    textStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
              )
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            child: Row(
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CollectionCard(
                    color: Color(0xFFFFEBDD),
                    image: 'assets/card.png',
                    title: 'Anatomy',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CollectionCard(
                    color: Color(0xFFDFF5FF),
                    image: 'assets/blockchain.png',
                    title: 'Blockchain',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CollectionCard(
                    color: Color(0xFFDDE1FF),
                    image: 'assets/bars.png',
                    title: 'Statistics',
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CommunityLib extends StatefulWidget {
  const CommunityLib({super.key});

  @override
  State<CommunityLib> createState() => _CommunityLibState();
}

class _CommunityLibState extends State<CommunityLib> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FriendsCard(),
          SizedBox(
            height: 20,
          ),
          "Popular Collections"
              .text
              .size(24)
              .medium
              .caption(context)
              .make()
              .pOnly(left: 10, top: 0, bottom: 10),
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PopularCollectionCard(),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class PopularCollectionCard extends StatefulWidget {
  final _imgUrl = "assets/libimage.png";
  final _title = "Lorem Ipsum";
  final _subtitle =
      "Lorem Ipsum nvvbhasuobhuon 7afo ah fayu gyhvhashubvgagiycviagiyfgasib  fyygsdhyudbusi  gfgfyugbgshv";
  final _rating = 4.5;

  const PopularCollectionCard({super.key});

  @override
  State<PopularCollectionCard> createState() => _PopularCollectionCardState();
}

class _PopularCollectionCardState extends State<PopularCollectionCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Container(
        // height: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Image.asset(
                    widget._imgUrl,
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: 120,
                    fit: BoxFit.fill,
                  ).p8(),
                ),
                "700+ Cards"
                    .text
                    .size(12)
                    .bold
                    .make()
                    .pOnly(left: 10, bottom: 10),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Container(
                // height: 100,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget._title.text.size(16).bold.start.make(),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: RatingBar.builder(
                            initialRating: widget._rating,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: MediaQuery.of(context).size.width * 0.04,
                            itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                            unratedColor: Colors.amber.withAlpha(50),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                        ),
                        widget._rating
                            .toString()
                            .text
                            .size(12)
                            .caption(context)
                            .make()
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: Text(
                        widget._subtitle,
                        // softWrap: false,
                        overflow: TextOverflow.clip,
                        maxLines: 3,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FriendsCard extends StatefulWidget {
  const FriendsCard({super.key});

  @override
  State<FriendsCard> createState() => _FriendsCardState();
}

class _FriendsCardState extends State<FriendsCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'See All',
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                          color: Color(0xFFABABAB),
                          fontWeight: FontWeight.w600,
                          fontSize: 15)),
                ),
              ],
            ),
          ),
          Container(
            height: 100,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.width * 0.11,
                      width: MediaQuery.of(context).size.width * 0.11,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/avatar.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ).p8(),
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 10,
                          color: Color.fromARGB(255, 98, 230, 103),
                        ),
                        "Alexa".text.size(10).bold.make(),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.width * 0.11,
                      width: MediaQuery.of(context).size.width * 0.11,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/avatar.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ).p8(),
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 10,
                          color: Color.fromARGB(255, 98, 230, 103),
                        ),
                        "Alexa".text.size(10).bold.make(),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.width * 0.11,
                      width: MediaQuery.of(context).size.width * 0.11,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/avatar.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ).p8(),
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 10,
                          color: Color.fromARGB(255, 98, 230, 103),
                        ),
                        "Alexa".text.size(10).bold.make(),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.width * 0.11,
                      width: MediaQuery.of(context).size.width * 0.11,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/avatar.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ).p8(),
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 10,
                          color: Color.fromARGB(255, 98, 230, 103),
                        ),
                        "Alexa".text.size(10).bold.make(),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.width * 0.11,
                      width: MediaQuery.of(context).size.width * 0.11,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/avatar.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ).p8(),
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 10,
                          color: Color.fromARGB(255, 98, 230, 103),
                        ),
                        "Alexa".text.size(10).bold.make(),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
