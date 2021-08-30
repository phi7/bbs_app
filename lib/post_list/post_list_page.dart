import 'package:bbs_app/add_post/add_post_model.dart';
import 'package:bbs_app/add_post/add_post_page.dart';
import 'package:bbs_app/domain/post.dart';
import 'package:bbs_app/post_list/post_list_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PostListModel>(
      create: (_) => PostListModel()..fetchPostList(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("掲示板"),
        ),
        body: Center(
          child: Consumer<PostListModel>(builder: (context, model, child) {
            final List<Post>? posts = model.posts;

            if (posts == null) {
              return CircularProgressIndicator();
            }

            //postsをwidgetに変換する
            final List<Widget> widgets = posts
                .map((post) => ListTile(
                      title: Text(post.title),
                      subtitle: Text(post.content),
                    ))
                .toList();
            ;
            return ListView(
              children: widgets,
            );
          }),
        ),
        floatingActionButton: Consumer<PostListModel>(builder: (context, model, child) {
            return FloatingActionButton(
              onPressed: () async{
                //画面遷移を書いていく
                final bool? added = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    //「:」は代入して表示までやってくれてる？？？　bool fullscreenDialog = falseより
                    fullscreenDialog: true,
                    builder: (context) => AddPostPage(),
                  ),
                );

                if(added != null && added){
                  final snackBar = SnackBar(
                    backgroundColor: Colors.green,
                    content: Text(
                      "${model.posts}を追加しました",
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                //addPostで追加した文を更新して表示したいので再度呼び戻し。そのための上のasync,await。
                model.fetchPostList();

              },
              tooltip: 'Increment',
              child: Icon(Icons.add),
            );
          }
        ),
      ),
    );
  }
}
