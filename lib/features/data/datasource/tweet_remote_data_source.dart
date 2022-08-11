import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:twitter_app/features/data/models/tweet_model.dart';

import '../../domain/entities/tweet.dart';

abstract class TweetRemoteDataSource {
  Stream<List<Tweet>> getTweet(String uid);
  Future<void> addTweet(Tweet tweet);
  Future<void> deleteTweet(Tweet tweet);
  Future<void> editTweet(Tweet tweet);
}

class TweetRemoteDataSourceImpl extends TweetRemoteDataSource {
  final FirebaseFirestore firestore;

  TweetRemoteDataSourceImpl({required this.firestore});
  @override
  Stream<List<Tweet>> getTweet(String uid) {
    final tweetCollectionRef = firestore
        .collection('users')
        .doc(uid)
        .collection('tweet')
        .orderBy('created_at', descending: true);
    return tweetCollectionRef.snapshots().map(
        (query) => query.docs.map((e) => TweetModel.fromSnapshot(e)).toList());
  }

  @override
  Future<void> addTweet(Tweet tweet) async {
    final tweetCollectionRef =
        firestore.collection('users').doc(tweet.uid).collection('tweet');
    final tweetId = tweetCollectionRef.doc().id;
    tweetCollectionRef.doc(tweetId).get().then((value) {
      final newTweet = TweetModel(
              id: tweetId,
              tweet: tweet.tweet,
              createdAt: tweet.createdAt,
              uid: tweet.uid)
          .toDocument();
      tweetCollectionRef.doc(tweetId).set(newTweet);
    });
  }

  @override
  Future<void> deleteTweet(Tweet tweet) async {
    final tweetCollectionRef =
        firestore.collection('users').doc(tweet.uid).collection('tweet');
    tweetCollectionRef.doc(tweet.id).get().then((value) {
      if (value.exists) {
        tweetCollectionRef.doc(tweet.id).delete();
      }
      return;
    });
  }

  @override
  Future<void> editTweet(Tweet tweet) async {
    Map<String, dynamic> tweetMap = {};

    final tweetCollectionRef =
        firestore.collection('users').doc(tweet.uid).collection('tweet');

    if (tweet.tweet != null) {
      tweetMap['tweet'] = tweet.tweet;
    }
    if (tweet.createdAt != null) {
      tweetMap['created_at'] = tweet.createdAt;
    }

    tweetCollectionRef.doc(tweet.id).update(tweetMap);
  }
}
