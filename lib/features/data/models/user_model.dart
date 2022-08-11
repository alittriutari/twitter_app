import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:twitter_app/features/domain/entities/user.dart';

class UserModel extends Users {
  const UserModel(
      {required String? email, required String? uid, String? password})
      : super(email: email, uid: uid, password: password);

  factory UserModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return UserModel(
      uid: documentSnapshot.get('uid'),
      email: documentSnapshot.get('email'),
    );
  }

  Map<String, dynamic> toDocument() {
    return {'uid': uid, 'email': email, 'password': password};
  }
}
