import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class SavedQuotesScreen extends StatefulWidget {
  const SavedQuotesScreen({Key? key}) : super(key: key);

  @override
  _SavedQuotesScreenState createState() => _SavedQuotesScreenState();
}

class _SavedQuotesScreenState extends State<SavedQuotesScreen> {
  List<String> images = [
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text(
            "Saved Quote",
            style: Theme.of(context).textTheme.headline6,
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () => Navigator.pop(context, false),
          ),
        ),
        body: Container(
            padding: EdgeInsets.all(12.0),
            child: GridView.builder(
              itemCount: images.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              height: 150,
                              child: AutoSizeText(
                                images[index],
                                style: Theme.of(context).textTheme.bodyText1,
                              )),
                          Container(
                            height: 30,
                            child: AutoSizeText("Here comes author name",style: Theme.of(context).textTheme.subtitle1,),
                          )
                        ],
                      ),
                    ));
              },
            )));
  }
}
