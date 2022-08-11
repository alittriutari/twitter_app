import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:twitter_app/features/data/datasource/auth_remote_data_source.dart';
import 'package:twitter_app/features/data/datasource/tweet_remote_data_source.dart';
import 'package:twitter_app/features/data/repositories/auth_repository_impl.dart';
import 'package:twitter_app/features/data/repositories/tweet_repository_impl.dart';
import 'package:twitter_app/features/domain/repositories/auth_repository.dart';
import 'package:twitter_app/features/domain/repositories/tweet_repository.dart';
import 'package:twitter_app/features/domain/usecases/add_tweet.dart';
import 'package:twitter_app/features/domain/usecases/delete_tweet.dart';
import 'package:twitter_app/features/domain/usecases/do_logout.dart';
import 'package:twitter_app/features/domain/usecases/do_sign_in.dart';
import 'package:twitter_app/features/domain/usecases/do_sign_up.dart';
import 'package:twitter_app/features/domain/usecases/edit_tweet.dart';
import 'package:twitter_app/features/domain/usecases/get_current_uid.dart';
import 'package:twitter_app/features/domain/usecases/get_tweet.dart';
import 'package:twitter_app/features/domain/usecases/is_sign_in.dart';
import 'package:twitter_app/features/presentation/cubit/auth_cubit.dart';
import 'package:twitter_app/features/presentation/cubit/tweet_cubit.dart';
import 'package:twitter_app/features/presentation/cubit/users_cubit.dart';

final locator = GetIt.instance;

Future<void> init() async {
  //cubit
  locator.registerFactory<UsersCubit>(
      () => UsersCubit(doSignUp: locator(), doSignIn: locator()));
  locator.registerFactory<AuthCubit>(() => AuthCubit(
      isSignIn: locator(), getCurrentUid: locator(), doLogout: locator()));
  locator.registerFactory<TweetCubit>(() => TweetCubit(
      addTweet: locator(),
      getTweet: locator(),
      deleteTweet: locator(),
      editTweet: locator()));

  //usecases
  locator
      .registerLazySingleton<DoSignUp>(() => DoSignUp(repository: locator()));
  locator
      .registerLazySingleton<DoSignIn>(() => DoSignIn(repository: locator()));
  locator
      .registerLazySingleton<IsSignIn>(() => IsSignIn(repository: locator()));
  locator.registerLazySingleton<GetCurrentUid>(
      () => GetCurrentUid(repository: locator()));
  locator
      .registerLazySingleton<DoLogout>(() => DoLogout(repository: locator()));
  locator
      .registerLazySingleton<AddTweet>(() => AddTweet(repository: locator()));
  locator
      .registerLazySingleton<GetTweet>(() => GetTweet(repository: locator()));
  locator.registerLazySingleton<DeleteTweet>(
      () => DeleteTweet(repository: locator()));
  locator
      .registerLazySingleton<EditTweet>(() => EditTweet(repository: locator()));

  //repository
  locator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(dataSource: locator()));
  locator.registerLazySingleton<TweetRepository>(
      () => TweetRepositoryImpl(dataSource: locator()));

  //data source
  locator.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(firebaseAuth: locator()));
  locator.registerLazySingleton<TweetRemoteDataSource>(
      () => TweetRemoteDataSourceImpl(firestore: locator()));

  //external
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;

  locator.registerLazySingleton(() => auth);
  locator.registerLazySingleton(() => fireStore);
  locator.registerLazySingleton<GlobalKey<ScaffoldState>>(
      () => GlobalKey<ScaffoldState>());
  locator.registerLazySingleton<GlobalKey<FormState>>(
      () => GlobalKey<FormState>());
}
