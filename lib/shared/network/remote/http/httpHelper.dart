import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../../../../models/loginModel.dart';

class MyHttpOverrides extends HttpOverrides{
 @override
 HttpClient createHttpClient(SecurityContext? context){
  return super.createHttpClient(context)
   ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
 }
}


var BASEURL ='https://quizu.okoul.com/';


postData ({
  required String? baseUrl,
  required Map<String, dynamic>? body,
  token
})async{
 var client=http.Client();
var url=Uri.parse('$BASEURL$baseUrl');
return await client.post(url,
  headers: {
    'Authorization': token??'',
},
body: body,
);
 }
Future  getData({
  required String baseUrl,
  Map<String, dynamic>? query,
  token
})async{
  var client=http.Client();
   var url=Uri.parse('$BASEURL$baseUrl');
  return await client.get(
      url,
      headers: {
        'Authorization': token,
  });

}