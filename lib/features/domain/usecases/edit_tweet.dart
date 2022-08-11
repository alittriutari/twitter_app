import 'package:twitter_app/features/domain/entities/tweet.dart';
import 'package:twitter_app/features/domain/repositories/tweet_repository.dart';

class EditTweet {
  final TweetRepository repository;

  EditTweet({required this.repository});

  Future<void> call(Tweet tweet) async {
    return repository.editTweet(tweet);
  }
}
