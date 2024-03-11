import 'package:flutter/material.dart';
import 'package:homework_1/models/ArticleModel.dart';
import 'package:homework_1/models/NewsModel.dart';
import 'package:homework_1/views/article_view.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ArticleModel> articles = List<ArticleModel>.empty();
  bool _loading = true;

  getNews() async {
    News news = News();
    await news.getNews();
    setState(() {
      articles = news.news;
      _loading = false;
      print(articles);
    });
  }

  @override
  void initState() {
    getNews();
  }

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      appBar: AppBar(
          title: const Row(
        children: <Widget>[
          Text("Flutter"),
          Text(
            "News",
            style: TextStyle(color: Colors.blue),
          )
        ],
      )),
      body: _loading
          ? Container(
              child: const CircularProgressIndicator(),
            )
          : Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                itemCount: articles.length,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return BlogTile(
                    model: articles[index],
                  );
                },
              ),
            ),
    );
  }
}

class Card extends StatelessWidget {
  final imageUrl, categoryName;
  const Card({super.key, this.imageUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Image.network(
            imageUrl,
            width: 120,
            height: 60,
          ),
        ],
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  // final String imageUrl, title, desc,url;
  // const BlogTile(
  //     {super.key,
  //     required this.imageUrl,
  //     required this.title,
  //     required this.desc,
  //     required this.url});
  late ArticleModel model;
  BlogTile({
    super.key,
    required this.model,
});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
         builder: (context) => ArticleView(model: model)
        ));
      },
      // margin: EdgeInsets.only(bottom: 20),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
              child: Image.network(model.urlToImage)
          ),

          Text(model.title,style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600
          )
            ,),
          SizedBox(height: 8),
          Text(model.description)],
      ),
    );
  }
}
