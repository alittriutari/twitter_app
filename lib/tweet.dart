// class Tweet {
//   final int id;
//   final String tweet;
//   final DateTime createdAt;
//   final DateTime updatedAt;

//   Tweet({required this.id, required this.tweet, required this.createdAt, required this.updatedAt});

//   Tweet.fromSnapshot(QueryDocumentSnapshot snapshot) {
//     id = snapshot.id;

//     tweet = snapshot['tweet'];
//     createdAt = snapshot['created_at']?.toDate();
//     updatedAt = snapshot['updated_at']?.toDate();
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};

//     data['tweet'] = tweet;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     return data;
//   }
// }
