import 'dart:convert';
import 'dart:io';

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
  List<QuoteModel> quoteDetails;
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
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xffbdd2b6)),
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
                                          Share.share(quoteDetails[0].q +
                                              '\n~' +
                                              quoteDetails[0].a);
                                      },
                                      child: Icon(Icons.ios_share))
                                ],
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: quoteDetails == null
                                    ? Text(
                                        message,
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Raleway',
                                            letterSpacing: 0.3),
                                      )
                                    : Text(
                                        "“" + quoteDetails[0].q + "”",
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Raleway',
                                            letterSpacing: 0.3),
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
                                          "~" + quoteDetails[0].a,
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Raleway',
                                              letterSpacing: 0.3),
                                        ),
                                ],
                              )
                            ],
                          ),
                        ))),
                TextButton(
                    onPressed: _getResponse,
                    child: Container(
                      color: Color(0xffa2b29f),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          "Get Quote",
                          style: TextStyle(
                              color: Color(0xfff8ede3),
                              fontSize: 20,
                              fontFamily: 'Raleway'),
                        ),
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
    List<QuoteModel> quoteModel = quoteModelFromMap(response.body);
    if (quoteModel.isNotEmpty && quoteModel.length > 0) {
      quoteDetails = quoteModel;
    } else {
      setState(() {
        message = "Cannot Find any quote right now please try again later!";
      });
    }
    setState(() {});
  }
}
