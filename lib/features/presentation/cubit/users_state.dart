part of 'users_cubit.dart';

abstract class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object> get props => [];
}

class UsersInitial extends UsersState {}

class UserLoading extends UsersState {}

class UsersLoaded extends UsersState {}

class UserFailure extends UsersState {}
