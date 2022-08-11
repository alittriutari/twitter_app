part of 'tweet_cubit.dart';

abstract class TweetState extends Equatable {
  const TweetState();

  @override
  List<Object> get props => [];
}

class TweetInitial extends TweetState {}

class TweetLoading extends TweetState {}

class TweetEmpty extends TweetState {}

class TweetLoaded extends TweetState {
  final List<Tweet> tweet;
  const TweetLoaded({required this.tweet});

  @override
  List<Object> get props => [tweet];
}

class TweetSuccess extends TweetState {}

class TweetFailure extends TweetState {}
