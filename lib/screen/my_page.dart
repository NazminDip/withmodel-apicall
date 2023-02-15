import 'dart:convert';

import 'package:app/model/post_model.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  List<PostModel> postlist = [];

  Future<List<PostModel>> getPhotos() async {
    final res = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/comments?postId=1"));
    var data = jsonDecode(res.body.toString());
    if (res.statusCode == 200) {
      postlist.clear();
      for (Map i in data) {
        PostModel photos = PostModel(
            postId: i['postId'],
            id: i["id"],
            name: i['name'],
            email: i['email'],
            body: i['body']);
        postlist.add(photos);
      }
      return postlist;
    } else {
      return postlist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Api Data Call'),
        backgroundColor: Colors.red,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const MyPage()));
          },
          icon: const Icon(
            Icons.arrow_forward,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPhotos(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text(
                        'Loading.....',
                        style: TextStyle(color: Colors.red, fontSize: 30),
                      ),
                    );
                  }
                  return ListView.builder(
                      itemCount: postlist.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "Post Id : ${postlist[index].postId.toString()}"),
                              ListTile(
                                subtitle: Text(
                                    "Body :${postlist[index].body.toString()}"),
                                leading: Text(
                                    "Id : ${postlist[index].id.toString()}"),
                                trailing: Text(
                                    "Email : ${postlist[index].email.toString()}"),
                                title: Text(
                                    "Name :${postlist[index].name.toString()}"),
                              ),
                            ],
                          ),
                        );
                      });
                }),
          )
        ],
      ),
    );
  }
}
