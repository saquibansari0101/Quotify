import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddQuoteScreen extends StatefulWidget {
  const AddQuoteScreen({Key? key}) : super(key: key);

  @override
  _AddQuoteScreenState createState() => _AddQuoteScreenState();
}

class _AddQuoteScreenState extends State<AddQuoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text("Add Quote",style: Theme.of(context).textTheme.headline6,),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: Center(
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
