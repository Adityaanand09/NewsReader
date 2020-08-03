import 'package:http/http.dart' as http;
import 'articles.dart';
import 'dart:convert';
class News{
  List<Article> news = [];
  String headLine = 'top-headlines';
  Future<void> getNews() async{
    String url = 'http://newsapi.org/v2/${headLine}?country=in&category=business&apiKey=b5fd2f4e31ab4f1ba662fba621b6d642';
  var response = await http.get(url);

  var jsonData = jsonDecode(response.body);
  if(jsonData['status'] == 'ok')
    {

      jsonData['articles'].forEach((element){
        if(element['urlToImage']!=null){
          Article article =Article(
            title:element['title'],
            author:element['author'],
            description:element['description'],
            urltoImage: element['urlToImage'],
            publishedAt:DateTime.parse(element['publishedAt']),
            content: element['content'],
          );
          news.add(article);
        }
      });
    }

  }
}