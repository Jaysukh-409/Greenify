import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:greenify_new/utilities/post.dart';
import 'package:greenify_new/utilities/storagemethod.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> uploadpost(
    String description,
    Uint8List file,
    String uid,
    String username,
    String profImage,
  ) async {
    String res = "Some Error Occured";
    try {
      String photourl =
          await StorageMethod().uploadtostorage('posts', file, true);

      String postId = const Uuid().v1();

      _firestore
          .collection('users')
          .doc(uid)
          .update({'postCount': FieldValue.increment(1)});

      Post post = Post(
        description: description,
        uid: uid,
        username: username,
        postid: postId,
        postUrl: photourl,
        datePublished: DateTime.now(),
        profImage: profImage,
        likes: [],
        isVerified: false,
      );

      _firestore.collection('posts').doc(postId).set(
            post.toJson(),
          );

      res = "Success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
