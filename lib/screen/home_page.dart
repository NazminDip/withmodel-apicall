import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart ' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ignore: prefer_typing_uninitialized_variables
  var data = [];

  Future getData() async {
    final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts/1/comments'));

    if (response.statusCode == 200) {
      // ignore: unused_local_variable
      var data = jsonDecode(response.body).toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: getData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text('Loading');
                    } else {
                      return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Text(data[index]['name'].toString()),
                              trailing: Text(data[index]['body'].toString()),
                            );
                          });
                    }
                  }),
            ),
          ],
        ));
  }
}
