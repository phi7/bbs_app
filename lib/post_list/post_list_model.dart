import 'package:bbs_app/domain/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostListModel extends ChangeNotifier {
  List<Post>? posts;

  void fetchPostList() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('posts').get();

    final List<Post> posts = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String id = document.id;
      final String title = data["title"];
      final String content = data["content"];
      //Post型のリストに代入される値を返す
      return Post(id,title, content);
    }).toList();

    this.posts = posts;
    //変化を検知し得たことを伝える、Consumerの方で発火して読み込まれる。
    notifyListeners();
  }

  Future delete(Post post) async{
    return await FirebaseFirestore.instance.collection('posts')
        .doc(post.id)
        .delete();
  }
}
