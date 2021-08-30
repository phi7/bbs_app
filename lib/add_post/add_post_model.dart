import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddPostModel extends ChangeNotifier {
  String? title;
  String? content;

  CollectionReference posts = FirebaseFirestore.instance.collection('posts');

  Future addPost() async {
    if(title==null || title == ""){
      throw "タイトルが入力されていないです";
    }

    if(content==null || content!.isEmpty){
      throw "本文が入力されていないです";
    }

    //firestoreに追加
    await FirebaseFirestore.instance.collection('posts').add({
      'title': title,
      'content': content,
    });
  }
}