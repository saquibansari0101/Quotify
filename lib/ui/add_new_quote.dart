import 'package:Quotify/util/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddQuoteScreen extends StatefulWidget {
  const AddQuoteScreen({Key? key}) : super(key: key);

  @override
  _AddQuoteScreenState createState() => _AddQuoteScreenState();
}

class _AddQuoteScreenState extends State<AddQuoteScreen> {
  TextEditingController quote = TextEditingController();
  TextEditingController author = TextEditingController();


  @override
  void initState() {

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
          children: [
            Image.asset("assets/gif/cthink1.gif",width: 300,),
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
                    readOnly: false,
                    labelText: "Author",
                    hintText: "Author",
                    context: context,
                    controller: author,
                    keyboard: TextInputType.text)),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ElevatedButton(
                  onPressed: () {},
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
}
