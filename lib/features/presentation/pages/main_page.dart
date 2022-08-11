import 'package:flutter/material.dart';
import 'package:twitter_app/features/presentation/pages/signin_page.dart';
import 'package:twitter_app/features/presentation/pages/signup_page.dart';

class MainPage extends StatefulWidget {
  static const routeName = '/main_page';
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            children: [
              const AspectRatio(
                aspectRatio: 1,
                child: Center(
                  child: Text(
                    "See what's happening in the world right now.",
                    style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1.5,
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: ElevatedButton(
                      onPressed: () async {
                        Navigator.pushNamed(context, SignUpPage.routeName);
                      },
                      child: const Text('Create account')),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, SignInPage.routeName);
                      },
                      child: const Text('Sign In')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
