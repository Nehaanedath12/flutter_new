import 'dart:convert';

import 'package:http/http.dart' as http;

class UserApiProvider{
Future  getNews() async {
    var result ;
  try{

 final String url= 'https://newsapi.org/v2/everything?q=apple&from=2022-10-11&to=2022-10-11&sortBy=popularity&apiKey=2bb2ccde9d1c424787cf3857ae1908e2';
  var dataResult= await http.get(Uri.parse(url));
  

  // if(result.statusCode==200){
  //     print('result>>:'+result.body.toString());
  // }else{
  //       print('rrr'+result.toString());
  // }
  result=dataResult.body;
  print("result $result");
  
  }catch(error){
    print(error);
  }
    return result;
  }
  

}
final apiProvider = UserApiProvider();