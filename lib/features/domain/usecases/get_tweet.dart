import 'package:twitter_app/features/domain/entities/tweet.dart';
import 'package:twitter_app/features/domain/repositories/tweet_repository.dart';

class GetTweet {
  final TweetRepository repository;

  GetTweet({required this.repository});

  Stream<List<Tweet>> call(String uid) {
    return repository.getTweet(uid);
  }
}
