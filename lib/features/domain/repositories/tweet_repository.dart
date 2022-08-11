import 'package:twitter_app/features/domain/entities/tweet.dart';

abstract class TweetRepository {
  Stream<List<Tweet>> getTweet(String uid);
  Future<void> addTweet(Tweet tweet);
  Future<void> editTweet(Tweet tweet);
  Future<void> deleteTweet(Tweet tweet);
}
