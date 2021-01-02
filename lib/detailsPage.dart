import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model/data.dart';

class DetailsPage extends StatefulWidget {
  Data data;
  DetailsPage(this.data);
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
      ),
      body: ListView(
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.network(
                  widget.data.url,
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 7.0),
                Text(
                  widget.data.title
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
