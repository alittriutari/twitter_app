import 'package:equatable/equatable.dart';

class Users extends Equatable {
  final String? uid;
  final String? email;
  final String? password;

  const Users({required this.email, this.uid, this.password});

  @override
  List<Object?> get props => [email, uid, password];
}
