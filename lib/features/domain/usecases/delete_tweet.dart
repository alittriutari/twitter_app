import 'package:twitter_app/features/domain/entities/tweet.dart';
import 'package:twitter_app/features/domain/repositories/tweet_repository.dart';

class DeleteTweet {
  final TweetRepository repository;

  DeleteTweet({required this.repository});

  Future<void> call(Tweet tweet) async {
    return await repository.deleteTweet(tweet);
  }
}
