import 'package:Quotify/database/quote_dao.dart';
import 'package:Quotify/database/quote_entity.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class SavedQuotesScreen extends StatefulWidget {
  final QuoteDao quoteDao;

  const SavedQuotesScreen(this.quoteDao, {Key? key}) : super(key: key);

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
        backgroundColor: Theme
            .of(context)
            .backgroundColor,
        appBar: AppBar(
          title: Text(
            "Saved Quote",
            style: Theme
                .of(context)
                .textTheme
                .headline6,
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
            child: StreamBuilder<List<Quote>>(
                stream: widget.quoteDao.findAllQuotesAsStream(),
                builder: (_, snapshot) {
                  if (!snapshot.hasData) return Container();
                  final quotes = snapshot.requireData;
                  return GridView.builder(
                    itemCount: quotes.length,
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, crossAxisSpacing: 10.0, mainAxisSpacing: 10.0),
                    itemBuilder: (_, int index) {
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
                                      quotes[index].quote!,
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .bodyText1,
                                    )),
                                Container(
                                  height: 30,
                                  child: AutoSizeText(quotes[index].author!, style: Theme
                                      .of(context)
                                      .textTheme
                                      .subtitle1,),
                                )
                              ],
                            ),
                          ));
                    },
                  );
                }
            )));
  }
}
