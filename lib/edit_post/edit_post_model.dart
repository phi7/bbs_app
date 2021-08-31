import 'package:bbs_app/domain/post.dart';
import 'package:bbs_app/edit_post/edit_post_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditPostModel extends ChangeNotifier {
  final Post post;
  EditPostModel(this.post){
    titleController.text = post.title;
    contentController.text = post.content;
  }

  final titleController = TextEditingController();
  final contentController = TextEditingController();

  String? title;
  String? content;

  void setTitle(String title){
    this.title = title;
    notifyListeners();
  }

  void setContent(String content){
    this.content = content;
    notifyListeners();
  }

  bool isUpdated(){
    return title != null || content != null;
  }

  CollectionReference posts = FirebaseFirestore.instance.collection('posts');

  Future update() async {
    this.title = titleController.text;
    this.content = contentController.text;

    //firestoreに追加
    await FirebaseFirestore.instance.collection('posts').doc(post.id).update({
      'title': title,
      'content': content,
    });
  }
}