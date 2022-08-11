import 'package:twitter_app/features/data/datasource/tweet_remote_data_source.dart';
import 'package:twitter_app/features/domain/entities/tweet.dart';
import 'package:twitter_app/features/domain/repositories/tweet_repository.dart';

class TweetRepositoryImpl extends TweetRepository {
  final TweetRemoteDataSource dataSource;

  TweetRepositoryImpl({required this.dataSource});
  @override
  Stream<List<Tweet>> getTweet(String uid) => dataSource.getTweet(uid);

  @override
  Future<void> addTweet(Tweet tweet) async => dataSource.addTweet(tweet);

  @override
  Future<void> deleteTweet(Tweet tweet) async => dataSource.deleteTweet(tweet);

  @override
  Future<void> editTweet(Tweet tweet) async => dataSource.editTweet(tweet);
}
