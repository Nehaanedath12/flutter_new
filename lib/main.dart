
import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new/news.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'UserApiProvider.dart';




void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme:  ThemeData(
        primaryColor: Colors.blue
      ),
      home: HomeScreen(),
    );
  }
}
class HomeScreen extends StatefulWidget{
  @override
  _HomeScreenState createState() => _HomeScreenState();

}


class _HomeScreenState extends State<HomeScreen> {

late List<News>newsList=[];
bool loading=true;
StreamController<List> streamController = StreamController();
  late Future<List> _futureValue;



 @override
  void initState() {
    loading=false;
    // stream Bulder
   _getDataFromAPI();

   //futurebuilder
   _futureValue=getFuture_Value() ;
    super.initState();
  }

@override
  void dispose() {
    super.dispose();
    streamController.close();
  }

  @override
  Widget build(BuildContext context) {   
    return Scaffold(
      appBar: AppBar(title: 
      Text("News-On-The-Go",
      style: TextStyle(fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.transparent,
      ),
      body:Container(
        child: 

        // future builder code`
        FutureBuilder(builder: (context, snapshot) {

          if(snapshot.hasError){
            return Scaffold(body: Center(child: Text("ERror")),);
          }

          if(snapshot.connectionState==ConnectionState.waiting){

             return Scaffold(body: 
          Center(child: CircularProgressIndicator()),);
          }


          return _swiper();
        },
        initialData: "load...",
        future: _futureValue,)


//stream builder code



      //   StreamBuilder(
      //     initialData: "Loading..",
      // stream: streamController.stream,
      // builder: (context, snapshot) {

      //   if(snapshot.hasError)
      //   {
      //     return Scaffold(body: Text("errorr"),);
      //   }
      
      //   if(snapshot.connectionState==ConnectionState.waiting){

      //     return Scaffold(body: 
      //     Center(child: CircularProgressIndicator()),);

      //   }
      
      //   return _swiper();
     
        
      // })
          
   
       
      )


    );
  }


 newsContainerUI(News news)  {
    return Container(
        child:Stack(
          children: <Widget>[
            Positioned(
              height:MediaQuery.of(context).size.height*.5,
              width:  MediaQuery.of(context).size.width,
              child: Container(
                child: Card(
                  margin: EdgeInsets.zero,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                 child: Image.network(news.urlToImage!,
                                fit: BoxFit.fill,
                              ),
                            ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height*.35,
              
              width:   MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Container(
                width:150,
                height:150,
                child:   Card(
                   margin: EdgeInsets.zero,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(children: [
                                 Padding(
                                   padding: const EdgeInsets.all(15.0),
                  
                                   child: Text(news.title!,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                                 ),
                                   Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Text(news.title!,style: TextStyle(fontSize: 15),),
                                   ),
                                     Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Text(news.description!,
                                       style: TextStyle(fontSize: 15),),
                                     )
                      
                      
                               ],),
                  ),
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.only(
          topRight: Radius.circular(40.0),
          topLeft: Radius.circular(40.0),
          bottomLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0)),
                             ),
                             elevation: 5,
                           ),
              ),
            ),
           
          ],
        ),
    

    );

  }

_getDataFromAPI() async {
    try{
      await apiProvider.getNews().then((value) {
 var data = value;
  Map<String, dynamic> map = json.decode(data);
  List<dynamic> data3 = map["articles"];

      var loadNews =

          data3.map((i) =>
          
           News.fromJson(i)).toList();
           
      newsList.clear();
      for (var i in loadNews) {
        setState(() {
          newsList.add(i);
          
        });
      }
    
      });
      streamController.sink.add(newsList);
    
   
    }catch(error){
      print("error:$error");
    } 
 

  }

   _swiper() {
    return Scaffold(
      body: Container(
        child: Swiper(
                              autoplay: false,
                              scrollDirection: Axis.horizontal,
                              itemCount: newsList.length,
                              loop: false,
                              itemBuilder: (context, index) {
                                return newsContainerUI(newsList[index]);
                              },
                            ),
      ),
    );

  }

Future<List> getFuture_Value() async {

   try{
      await apiProvider.getNews().then((value) {
 var data = value;
  Map<String, dynamic> map = json.decode(data);
  List<dynamic> data3 = map["articles"];

      var loadNews =

          data3.map((i) =>
          
           News.fromJson(i)).toList();
           
      newsList.clear();
      for (var i in loadNews) {
        setState(() {
          newsList.add(i);
          
        });
      }
    
      });
    
   
    }catch(error){
      print("error:$error");
    } 

  return newsList;
}
  
}



