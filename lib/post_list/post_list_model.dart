import 'package:bbs_app/domain/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostListModel extends ChangeNotifier {
  //firebaseの値のコレクションを取得
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('posts').snapshots();

  List<Post>? posts;

  //取得したコレクションのうち、ほしいドキュメントのフィールドを返す。
  //fetchPostList()関数のおかげで変化をListenできる。上の_userStreamは定義しただけに過ぎない。
  //Listenして変化があったら、snapshotに入る。
  void fetchPostList() {
    _usersStream.listen((QuerySnapshot snapshot) {
      final List<Post> posts = snapshot.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        final String title = data["title"];
        final String content = data["content"];
        //Post型のリストに代入される値を返す
        return Post(title, content);
      }).toList();

      this.posts = posts;
      //変化を検知し得たことを伝える、Consumerの方で発火して読み込まれる。
      notifyListeners();
    });
  }
}
