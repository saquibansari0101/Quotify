import 'dart:developer';

import 'package:Quotify/database/quote_dao.dart';
import 'package:Quotify/database/quote_entity.dart';
import 'package:Quotify/util/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';

class AddQuoteScreen extends StatefulWidget {
  final QuoteDao quoteDao;

  const AddQuoteScreen(this.quoteDao, {Key? key}) : super(key: key);

  @override
  _AddQuoteScreenState createState() => _AddQuoteScreenState();
}

class _AddQuoteScreenState extends State<AddQuoteScreen> with TickerProviderStateMixin {

  TextEditingController quote = TextEditingController();
  TextEditingController author = TextEditingController();

  final GlobalKey<FormFieldState> _quoteFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _authorFormKey = GlobalKey<FormFieldState>();

  late GifController controller;

  @override
  void initState() {
    controller = GifController(vsync: this);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      controller.animateTo(24, duration: Duration(milliseconds: 500));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(
          "Add Quote",
          style: Theme.of(context).textTheme.headline6,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            GifImage(image: AssetImage("assets/gif/cthink1.gif"), controller: controller),
            // Image.asset("assets/gif/cthink1.gif",width: 300,),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Add your quotes here, you can access these from the saved quotes!",
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: customTextFormField(
                  validatorString: "Please Write Quote In The Box",
                  key: _quoteFormKey,
                  onChanged: (value){
                    setState(() {
                      _quoteFormKey.currentState!.validate();
                    });
                  },
                  validator: (value) {
                    RegExp regex = new RegExp(r"^[a-zA-Z ,.'-]+$");
                    return (regex.hasMatch(value!)) ? null : 'Please Write Quote In The Box';
                  },
                  readOnly: false,
                  labelText: "Quote",
                  hintText: "Quote",
                  context: context,
                  controller: quote,
                  prefixText: "“",
                  suffixText: "”",
                  keyboard: TextInputType.text),
            ),
            Padding(
                padding: const EdgeInsets.all(15.0),
                child: customTextFormField(
                    validatorString: "Please Write Author's Name In The Box",
                    key: _authorFormKey,
                    onChanged: (value){
                      setState(() {
                        _authorFormKey.currentState!.validate();
                      });
                    },
                    validator: (value) {
                      RegExp regex = new RegExp(r"^[a-zA-Z ,.'-]+$");
                      return (regex.hasMatch(value!)) ? null : 'Please Enter Valid Author\'s Name';
                    },
                    readOnly: false,
                    labelText: "Author",
                    hintText: "Author",
                    context: context,
                    controller: author,
                    keyboard: TextInputType.text)),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ElevatedButton(
                  onPressed: () async {
                    await _persistQuote();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          height: 60,
                          child: Center(
                              child: Text(
                            "Save",
                            style: Theme.of(context).textTheme.bodyText2,
                          ))),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _persistQuote() async {
    final quoteText = quote.text;
    final authorName = author.text;
    if (quoteText.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Quote Is Empty"),
        ),
      ));
    } else if (await widget.quoteDao.findIfPresent(quoteText) != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Quote Already Present In Saved"),
        ),
      ));
    } else {
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
