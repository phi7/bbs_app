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
            final List<Widget> widgets = posts.map((post) =>
                ListTile(title: Text(post.title), subtitle: Text(post.content),)).toList();;
            return ListView(
              children: widgets,
            );
          }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
