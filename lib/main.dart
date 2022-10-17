
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

 @override
  void initState() {
    loading=false;
    callNewsDetailsFrom();
    super.initState();
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
   
        child: Swiper(
                              autoplay: false,
                              scrollDirection: Axis.horizontal,
                              itemCount: newsList.length,
                              loop: false,
                              itemBuilder: (context, index) {
                                return newsContainerUI(newsList[index]);
                              },
                            ),
      )


    );
  }

  Future<void> callNewsDetailsFrom() async {
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
           print(i);
        });
      }
      });
    }catch(error){
      print("error:$error");
    } 
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
    

      // padding: const EdgeInsets.symmetric(horizontal: 22.0),
      //         child: Stack(
          
                // children: [
                //   Positioned(
                //     child: Container(
                //       height: 400,
                //       width: 350,
                //       child: Card(
                        
                //               semanticContainer: true,
                //               clipBehavior: Clip.antiAliasWithSaveLayer,
                //               child: Image.network(
                //                 'https://placeimg.com/640/480/any',
                //                 fit: BoxFit.fill,
                //               ),
                //               shape: RoundedRectangleBorder(
                //                 borderRadius: BorderRadius.circular(10,),
                //               ),
                //               elevation: 5,
                //             ),
                //     ),
      //             ), Positioned(
      //                 top: 300,
      //                 child: Container(
      //                 width: 315,
                      
      //                 child: 
                      // Card(child: Column(children: [
                      //          Padding(
                      //            padding: const EdgeInsets.all(8.0),

                      //            child: Text("Header or the news",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                      //          ),
                      //            Padding(
                      //              padding: const EdgeInsets.all(8.0),
                      //              child: Text("2020-03-05",style: TextStyle(fontSize: 14),),
                      //            ),
                      //              Padding(
                      //                padding: const EdgeInsets.all(8.0),
                      //                child: Text(" dtada is a a dtada is a a dtada is jgshgjkgaa a dtada is a a dtada is a a dtada is a a dtada is a a dtada is a a dtada is a a",style: TextStyle(),),
                      //              )
                    
                    
                      //        ],),
                      //        shape: RoundedRectangleBorder(
                      //          borderRadius: BorderRadius.circular(10,),
                      //        ),
                      //        elevation: 5,
                      //      ),
                          //  ),
      //               ),
      //           ],
      //         )
    );

  }
  
}



