import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';


void pedirDatos() async{
 var url = 'https://jsonplaceholder.typicode.com/users/1';

     Response response = await http.get(url);
     Map data = jsonDecode(response.body);
     var id = (data["id"]);
     print(id);


}