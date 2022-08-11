import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  static FirestoreServices? _instance;
  FirestoreServices._internal() {
    _instance = this;
  }
  factory FirestoreServices() => _instance ?? FirestoreServices._internal();
}

class TweetRepositorys {
  final _tweetCollection = FirebaseFirestore.instance.collection('tweet');

  Stream<QuerySnapshot> fetchTweet() {
    return _tweetCollection
        .orderBy('created_at', descending: false)
        .snapshots();
  }
}
