import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String username;
  final String postid;
  final datePublished;
  final String postUrl;
  final String profImage;
  final likes;
  final bool isVerified;

  const Post({
    required this.description,
    required this.uid,
    required this.username,
    required this.datePublished,
    required this.postid,
    required this.postUrl,
    required this.profImage,
    required this.likes,
    required this.isVerified,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "description": description,
        "postid": postid,
        "postUrl": postUrl,
        "datePublished": datePublished,
        "profImage": profImage,
        "likes": likes,
        "isVerified": isVerified,
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Post(
      username: snapshot['username'],
      uid: snapshot['uid'],
      description: snapshot['description'],
      datePublished: snapshot['datePublished'],
      profImage: snapshot['profImage'],
      likes: snapshot['likes'],
      postUrl: snapshot['postUrl'],
      postid: snapshot['postid'],
      isVerified: snapshot['isVerified'],
    );
  }
}
