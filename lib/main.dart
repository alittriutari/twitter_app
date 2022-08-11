import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_app/features/presentation/cubit/auth_cubit.dart';
import 'package:twitter_app/features/presentation/cubit/tweet_cubit.dart';
import 'package:twitter_app/features/presentation/cubit/users_cubit.dart';
import 'package:twitter_app/features/presentation/pages/home_page.dart';
import 'package:twitter_app/features/presentation/pages/main_page.dart';
import 'package:twitter_app/injection.dart' as di;
import 'package:twitter_app/routes.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UsersCubit>(
          create: (_) => di.locator<UsersCubit>(),
        ),
        BlocProvider<AuthCubit>(
          create: (_) => di.locator<AuthCubit>()..appStarted(),
        ),
        BlocProvider<TweetCubit>(
          create: (_) => di.locator<TweetCubit>(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Twitter App',
        theme: ThemeData(
          primaryColor: const Color(0xff1c9aef),
        ),
        initialRoute: '/',
        onGenerateRoute: Routes().route,
        routes: {
          '/': (context) {
            return BlocBuilder<AuthCubit, AuthState>(
                builder: (context, authState) {
              if (authState is Authenticated) {
                return HomePage(
                  uid: authState.uid,
                );
              }
              if (authState is UnAuthenticated) {
                return const MainPage();
              }
              return const Center(child: CircularProgressIndicator());
            });
          }
        },
      ),
    );
  }
}
