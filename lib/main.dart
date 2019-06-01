import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  var quote;
  

  MyApp({Key key, this.quote}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Quotes App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('English to Marathi Translation'),
        ),
        body: Center(
          child: FutureBuilder<Quote>(
            future: getQuote(), //sets the getQuote method as the expected Future
            builder: (context, snapshot) {
              if (snapshot.hasData) { //checks if the response returns valid data              
                return Center(
                  child: Column(
                    children: <Widget>[
                      Text(snapshot.data.quote), //displays the quote
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(" - ${snapshot.data.author}"), //displays the quote's author
                    ],
                  ),
                );
              } else if (snapshot.hasError) { //checks if the response throws an error
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }


  Future<Quote> getQuote() async {
    // String url = 'https://quotes.rest/qod.json';
    String url2 = 'https://translate.yandex.net/api/v1.5/tr.json/translate?key=trnsl.1.1.20190601T192331Z.b0e37cd519d41081.1e127d3c8195045f3489ea3c204579cbb12b0349&text=%3Chand%3E&lang=mr';
    // final response =
    //     await http.get(url, headers: {"Accept": "application/json"});
    var resp = await http.get(url2, headers: {"Accept": "application/json"});

    if (resp.statusCode == 200) {
      return Quote.fromJson(json.decode(resp.body));
    } else {
      throw Exception('Failed to load post');
    }

    // if (response.statusCode == 200) {
    //   return Quote.fromJson(json.decode(response.body));
    // } else {
    //   throw Exception('Failed to load post');
    // }
  }
}

class Quote {
  // final var authoe
  final String author;
  final String quote;

  Quote({this.author, this.quote});

  factory Quote.fromJson(Map<String, dynamic> json) {
        return Quote(
        author: json['text'][0].toString(),
    // return Quote(
    //     author: json['contents']['quotes'][0]['author'],
        // quote: json['contents']['quotes'][0]['quote']);
        quote: json['lang']);
  }
}