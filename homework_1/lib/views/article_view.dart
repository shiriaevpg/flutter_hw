import 'package:flutter/material.dart';
import 'package:homework_1/models/ArticleModel.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/NewsModel.dart';

class ArticleView extends StatelessWidget {
  late ArticleModel model;
  ArticleView({super.key, required this.model});

  void _launchURL() async {
    Uri uri = Uri.parse(model.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch ${model.url}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Flutter",
              style:
              TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
            ),
            Text(
              "News",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),

      body:
              SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.network(model.urlToImage,fit:BoxFit.cover),
                 Text(model.title,style: TextStyle(
                   fontSize: 17,
                   fontWeight: FontWeight.w600
                  ),
                ),
                   Text(model.content),
                    InkWell(
                      onTap: _launchURL,
                      child:  Text(
                        model.url,
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16.0,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                        // height: MediaQuery.of(context).size.height,
                        // width: MediaQuery.of(context).size.width
                    ),
              ),
            ),
    );
}
 }