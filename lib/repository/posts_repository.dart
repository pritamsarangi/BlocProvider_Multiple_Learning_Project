import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:blocprovider/model/posts_model.dart';
import 'package:http/http.dart' as http;

class PostRepository{
  Future<List<PostsModel>> fetchPost() async{
    try{
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));
      if(response.statusCode == 200){
        final body = json.decode(response.body) as List;
        return body.map((e) {
          return PostsModel(
            postId: e['postId'] as int,
            id: e['id'] as int,
            email: e['email'] as String,
            name: e['name'] as String,
            body: e['body'] as String,
          );
        }).toList();
      }
    }on SocketException{
      throw Exception('error while fetching data');
    }on TimeoutException{
      throw Exception('error while fetching data');
    }
    throw Exception('error while fetching data');
    }
  }