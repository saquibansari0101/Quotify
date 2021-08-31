import 'package:Quotify/ui/add_new_quote.dart';
import 'package:Quotify/ui/saved_quote.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:Quotify/data/quote_model.dart';
import 'package:Quotify/util/utility.dart';
import 'package:share/share.dart';

class Home extends StatefulWidget {
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
                Navigator.push(context, MaterialPageRoute(builder: (context)=> SavedQuotesScreen()));
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddQuoteScreen()));
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
                                  InkWell(
                                      onTap: () {
                                        if (quoteDetails != null)
                                          Share.share(quoteDetails!.content! + '\n~' + quoteDetails!.author!);
                                      },
                                      child: Icon(Icons.ios_share))
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
}
