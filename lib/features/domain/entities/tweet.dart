import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Tweet extends Equatable {
  final String? id;
  final String? tweet;
  final Timestamp? createdAt;
  final String? uid;

  const Tweet(
      {this.id,
      required this.tweet,
      required this.createdAt,
      required this.uid});

  @override
  List<Object?> get props => [id, tweet, createdAt, uid];
}
