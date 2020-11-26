import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PIMainCategoryFeedPage extends StatelessWidget {
  PIMainCategoryFeedPage({this.title});
  final String title;

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body:SizedBox.expand(
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              border:Border.all(width: 1, color: Colors.blue),
            ),
          ),
        )
    );
  }
}