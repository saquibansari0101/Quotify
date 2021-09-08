import 'dart:developer';

import 'package:Quotify/database/quote_dao.dart';
import 'package:Quotify/database/quote_entity.dart';
import 'package:Quotify/util/size_config.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';

class SavedQuotesScreen extends StatefulWidget {
  final QuoteDao quoteDao;

  const SavedQuotesScreen(this.quoteDao, {Key? key}) : super(key: key);

  @override
  _SavedQuotesScreenState createState() => _SavedQuotesScreenState();
}

class _SavedQuotesScreenState extends State<SavedQuotesScreen> {
  bool? isClicked;

  @override
  void initState() {
    super.initState();
    isClicked = false;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
            padding: EdgeInsets.only(left: SizeConfig.sidePadding!, right: SizeConfig.sidePadding!),
            child: StreamBuilder<List<Quote>>(
                stream: widget.quoteDao.findAllQuotesAsStream(),
                builder: (_, snapshot) {
                  if (!snapshot.hasData) return Container();
                  final quotes = snapshot.requireData;
                  return GridView.builder(
                    itemCount: quotes.length,
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: SizeConfig.screenWidth! / SizeConfig.screenHeight * 2,
                        crossAxisCount: 2,
                        crossAxisSpacing: SizeConfig.sidePadding!,
                        mainAxisSpacing: SizeConfig.sidePadding!),
                    itemBuilder: (_, int index) {
                      return Container(
                        height: 200,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.6), borderRadius: BorderRadius.circular(25)),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isClicked = false;
                            });
                            _showModalSheet(index, quotes[index]);
                            // print(SizeConfig.screenHeight);
                          },
                          child: Padding(
                            padding: EdgeInsets.all(SizeConfig.sidePadding!),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    height: SizeConfig.screenHeight * 0.17,
                                    child: AutoSizeText(
                                      quotes[index].quote!,
                                      style: Theme.of(context).textTheme.bodyText1,
                                    )),
                                Container(
                                  height: SizeConfig.screenHeight * 0.03,
                                  child: AutoSizeText(
                                    quotes[index].author!,
                                    style: Theme.of(context).textTheme.subtitle1,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                })));
  }

  void _showModalSheet(int index, Quote quote) {
    final key1 = UniqueKey();
    final key2 = UniqueKey();

    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        context: context,
        builder: (builder) {
          return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Theme.of(context).backgroundColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          isClicked!
                              ? Container(
                                  key: key1,
                                  height: 10,
                                  width: 10,
                                  color: Colors.blueAccent,
                                )
                              : Container(
                                  key: key2,
                                ),
                          IconButton(
                            icon: Icon(
                              Icons.copy_rounded,
                              size: 30,
                              color: Theme.of(context).splashColor,
                            ),
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: quote.quote));
                              setState(() {
                                isClicked = true;
                                log("Han click kiya hai");
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.ios_share,
                              size: 30,
                              color: Theme.of(context).splashColor,
                            ),
                            onPressed: () {
                              Share.share(quote.quote! + '\n~' + quote.author!);
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete_rounded,
                              size: 30,
                              color: Theme.of(context).errorColor,
                            ),
                            onPressed: () async {
                              await widget.quoteDao.deleteQuote(quote);
                              Navigator.pop(context);
                            },
                          )
                        ],
                      ),
                    ),
                    Container(
                        height: SizeConfig.screenHeight * 0.4,
                        child: AutoSizeText(
                          quote.quote!,
                          style: Theme.of(context).textTheme.bodyText1,
                        )),
                    Container(
                      height: SizeConfig.screenHeight * 0.03,
                      child: AutoSizeText(
                        "~" + quote.author!,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    )
                  ],
                ),
              ));
        });
  }
}
