import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:inter_iit/Cards/progressCard.dart';
import 'package:velocity_x/velocity_x.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.black,
        title: "Progress Dashboard".text.black.black.make(),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: ListView(children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: TextFormField(
              focusNode: FocusNode(
                
              ),
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
        ).p16(),
        Container(
          height: MediaQuery.of(context).size.height * 0.8,
          child: ListView.builder(
            itemCount: 10,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
            
            return const ProgressCard(
              image: 'assets/progress.png',
                  title: 'Evolution of Humans',
                  subtitle: 'Lorem Ipsum',
                  complete: 30,
                  total: 42,
                  color: Colors.green,
            ).p16();
          }),
        ),
      ]),
    );
  }
}