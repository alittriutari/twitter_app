import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:twitter_app/features/domain/entities/tweet.dart';

class TweetModel extends Tweet {
  const TweetModel({
    final String? id,
    final String? tweet,
    final Timestamp? createdAt,
    final String? uid,
  }) : super(uid: uid, createdAt: createdAt, tweet: tweet, id: id);

  factory TweetModel.fromSnapshot(DocumentSnapshot documentSnapshot) =>
      TweetModel(
          id: documentSnapshot.get('id'),
          tweet: documentSnapshot.get('tweet'),
          createdAt: documentSnapshot.get('created_at'),
          uid: documentSnapshot.get('uid'));

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'tweet': tweet,
      'created_at': createdAt,
      'uid': uid,
    };
  }
}
