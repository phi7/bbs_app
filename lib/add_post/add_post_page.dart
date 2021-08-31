import 'package:bbs_app/add_post/add_post_model.dart';
import 'package:bbs_app/domain/post.dart';
import 'package:bbs_app/post_list/post_list_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddPostModel>(
      create: (_) => AddPostModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("掲示板"),
        ),
        body: Center(
          child: Consumer<AddPostModel>(builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'タイトル',
                    ),
                    onChanged: (text) {
                      //ここで取得したテキストをうけとる
                      model.title = text;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: '本文',
                    ),
                    //textで内容をうけとる
                    onChanged: (text) {
                      //ここで取得したテキストをうけとる
                      model.content = text;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                      onPressed: () async{
                        //追加の処理
                        try {
                          await model.addPost();
                          Navigator.of(context).pop(true);
                        } catch (e) {
                          final snackBar = SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              e.toString(),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: Text("追加する")),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
