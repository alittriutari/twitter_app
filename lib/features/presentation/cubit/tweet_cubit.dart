import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:twitter_app/features/domain/entities/tweet.dart';
import 'package:twitter_app/features/domain/usecases/add_tweet.dart';
import 'package:twitter_app/features/domain/usecases/delete_tweet.dart';
import 'package:twitter_app/features/domain/usecases/edit_tweet.dart';
import 'package:twitter_app/features/domain/usecases/get_tweet.dart';

part 'tweet_state.dart';

class TweetCubit extends Cubit<TweetState> {
  final AddTweet addTweet;
  final GetTweet getTweet;
  final DeleteTweet deleteTweet;
  final EditTweet editTweet;
  TweetCubit(
      {required this.addTweet,
      required this.getTweet,
      required this.deleteTweet,
      required this.editTweet})
      : super(TweetInitial());

  Future<void> addingTweet(Tweet tweet) async {
    try {
      await addTweet(tweet);
      emit(TweetSuccess());
    } catch (e) {
      emit(TweetFailure());
    }
  }

  Future<void> fetchTweet(String uid) async {
    emit(TweetLoading());
    try {
      getTweet(uid).listen((event) {
        if (event.isEmpty) {
          emit(TweetEmpty());
        } else {
          emit(TweetLoaded(tweet: event));
        }
      });
    } catch (e) {
      emit(TweetFailure());
    }
  }

  Future<void> removeTweet(Tweet tweet) async {
    emit(TweetLoading());
    try {
      await deleteTweet(tweet);
      emit(TweetSuccess());
    } catch (e) {
      emit(TweetFailure());
    }
  }

  Future<void> updateTweet(Tweet tweet) async {
    emit(TweetLoading());
    try {
      await editTweet(tweet);
      emit(TweetSuccess());
    } catch (e) {
      emit(TweetFailure());
    }
  }
}
