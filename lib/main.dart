// ignore_for_file: prefer_const_constructors
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter API Demo',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> _data = [];

  Future<void> _getData() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (response.statusCode == 200) {
      setState(() {
        _data = json.decode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter API Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _getData,
              child: Text('Get Data'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_data[index]['title']),
                    subtitle: Text(_data[index]['body']),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}