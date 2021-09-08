import 'dart:developer';

import 'package:Quotify/database/quote_dao.dart';
import 'package:Quotify/database/quote_entity.dart';
import 'package:Quotify/ui/add_new_quote.dart';
import 'package:Quotify/ui/saved_quote.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:Quotify/data/quote_model.dart';
import 'package:Quotify/util/utility.dart';
import 'package:share/share.dart';

class Home extends StatefulWidget {
  final QuoteDao quoteDao;

  const Home(this.quoteDao);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  QuoteModel? quoteDetails;
  String message = "Click on \"Get Quote\" button to fetch quotes from server.";

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  @override
  initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
    _getResponse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff8ede3),
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Quotify',
          style: Theme.of(context).textTheme.headline6,
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            "assets/launcher/icon.png",
            height: 25,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
              iconSize: 30,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SavedQuotesScreen(widget.quoteDao)));
              },
              icon: Icon(
                Icons.book,
                color: Color(0xff798777),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
              iconSize: 30,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddQuoteScreen(widget.quoteDao)));
              },
              icon: Icon(
                Icons.add,
                color: Color(0xff798777),
              ),
            ),
          )
        ],
        backgroundColor: Color(0xfff8ede3),
        elevation: 0,
      ),
      body: Center(
        child: Container(
          color: Color(0xfff8ede3),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Color(0xffbdd2b6)),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                        onTap: () {
                                          if (quoteDetails != null) _persistQuote();
                                        },
                                        child: Icon(
                                          Icons.bookmark,
                                          size: 35,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                        onTap: () {
                                          if (quoteDetails != null)
                                            Share.share(quoteDetails!.content! + '\n~' + quoteDetails!.author!);
                                        },
                                        child: Icon(
                                          Icons.ios_share,
                                          size: 35,
                                        )),
                                  )
                                ],
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: quoteDetails == null
                                    ? Text(
                                        message,
                                        style: Theme.of(context).textTheme.bodyText1,
                                      )
                                    : Text(
                                        "“" + quoteDetails!.content! + "”",
                                        style: Theme.of(context).textTheme.bodyText1,
                                      ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  quoteDetails == null
                                      ? Text("")
                                      : Text(
                                          "~" + quoteDetails!.author!,
                                          style: Theme.of(context).textTheme.bodyText2,
                                        ),
                                ],
                              )
                            ],
                          ),
                        ))),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        onPrimary: Color(0xff798777),
                        primary: Color(0xffA2B29F),
                        onSurface: Color(0xff798777),
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                    onPressed: _getResponse,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Get Quote",
                        style: Theme.of(context).textTheme.button,
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _getResponse() async {
    Response response = await ApiClient().getMethodWithoutHeader();
    QuoteModel quoteModel = quoteModelFromJson(response.body);
    if (quoteModel.length! > 0) {
      quoteDetails = quoteModel;
    } else {
      setState(() {
        message = "Cannot Find any quote right now please try again later!";
      });
    }
    setState(() {});
  }

  Future<void> _persistQuote() async {
    final quoteText = quoteDetails!.content;
    final authorName = quoteDetails!.author;
    if (quoteText!.trim().isEmpty ) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Quote Is Empty"),
        ),
      ));
    } else if( await widget.quoteDao.findIfPresent(quoteText)!=null){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Quote Already Present In Saved"),
        ),
      ));
    }else {
      final quotem = Quote(id: null, author: authorName, quote: quoteText);
      await widget.quoteDao.insertQuote(quotem);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Quote Saved Successfully"),
        ),
      ));
      log("no fuck");
      // quote.clear();
    }
  }
}
