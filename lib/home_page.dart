import 'package:flutter/material.dart';
import 'news.dart';
import 'package:intl/intl.dart';
import 'player_widget.dart';
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool loading;
  var newsList;
  void getNews() async{
    News news =News();
    await news.getNews();
    setState(() {
      loading = false;
      newsList  = news.news;
    });
  }
  @override
  void initState() {
    loading = true;
    // TODO: implement initState
    super.initState();
    getNews();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:Padding(
          padding:EdgeInsets.symmetric(horizontal: 20.0),
          child:loading?Center(child:Text('Loading...')):
             Column( children:<Widget>[
               Row(
                 children:<Widget>[
                   Text('Top HeadLine',
                   style: TextStyle(
                     color:Colors.black,
                     fontSize:36.0,
                     fontWeight: FontWeight.bold,
                   ),)
                 ]
               ),
               Divider(),   //White line under headline
                 Expanded(
                   child: ListView.builder(
                     itemCount: newsList.length,
                       itemBuilder: (context,index){
                         return ListTile(
                           title:Text(
                               newsList[index].title),
                           subtitle:Text(DateFormat.Hm().format(newsList[index].publishedAt),),
                           leading: Image.network(newsList[index].urltoImage),
                           trailing:PlayerWidget(body:newsList[index].content) ,
                         );
                       }),
                 )

             ],
             ),
        ),
      ),
    );
  }
}
