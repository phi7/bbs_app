import 'package:bbs_app/add_post/add_post_model.dart';
import 'package:bbs_app/domain/post.dart';
import 'package:bbs_app/post_list/post_list_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'edit_post_model.dart';

class EditPostPage extends StatelessWidget {
  final Post post;

  EditPostPage(this.post);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditPostModel>(
      create: (_) => EditPostModel(post),
      child: Scaffold(
        appBar: AppBar(
          title: Text("掲示板"),
        ),
        body: Center(
          child: Consumer<EditPostModel>(builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: model.titleController,
                    decoration: InputDecoration(
                      hintText: 'タイトル',
                    ),
                    onChanged: (text) {
                      //ここで取得したテキストをうけとり、通知
                      model.setTitle(text);
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: model.contentController,
                    decoration: InputDecoration(
                      hintText: '本文',
                    ),
                    //textで内容をうけとる
                    onChanged: (text) {
                      //ここで取得したテキストをうけとり、通知
                      model.setContent(text);
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                      //更新できるように
                      onPressed: model.isUpdated()
                          ? () async {
                              //追加の処理
                              try {
                                await model.update();
                                Navigator.of(context).pop(model.title);
                              } catch (e) {
                                final snackBar = SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(
                                    e.toString(),
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            }
                          //isUpdatedがactiveじゃなければnullに
                          : null,
                      child: Text("更新する")),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
