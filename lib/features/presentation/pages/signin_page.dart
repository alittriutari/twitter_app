import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:twitter_app/features/domain/entities/user.dart';
import 'package:twitter_app/features/presentation/cubit/auth_cubit.dart';
import 'package:twitter_app/features/presentation/cubit/users_cubit.dart';
import 'package:twitter_app/features/presentation/pages/home_page.dart';
import 'package:twitter_app/features/presentation/widget/custom_text_field.dart';
import 'package:twitter_app/injection.dart';

class SignInPage extends StatefulWidget {
  static const routeName = '/sign_in';
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: locator<GlobalKey<ScaffoldState>>(),
      backgroundColor: Colors.white,
      body: BlocConsumer<UsersCubit, UsersState>(
        builder: (context, userState) {
          if (userState is UsersLoaded) {
            return BlocBuilder<AuthCubit, AuthState>(
                builder: (context, authState) {
              if (authState is Authenticated) {
                return HomePage(
                  uid: authState.uid,
                );
              } else {
                return _signInForm();
              }
            });
          }
          return _signInForm();
        },
        listener: (context, userState) {
          if (userState is UsersLoaded) {
            BlocProvider.of<AuthCubit>(context).loggedIn();
          }
        },
      ),
    );
  }

  Widget _signInForm() {
    return ModalProgressHUD(
      inAsyncCall: _loading,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Form(
                key: locator<GlobalKey<FormState>>(),
                child: Column(
                  children: [
                    CustomTextfield(
                      controller: emailController,
                      hintText: 'Email',
                      title: 'Email',
                      inputType: TextInputType.emailAddress,
                      showTitle: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextfield(
                      controller: passwordController,
                      inputType: TextInputType.visiblePassword,
                      hintText: 'Password',
                      title: 'Password',
                      obsecureText: true,
                      showTitle: true,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: ElevatedButton(
                          onPressed: () async {
                            if (locator<GlobalKey<FormState>>()
                                .currentState!
                                .validate()) {
                              setState(() {
                                _loading = true;
                              });
                              try {
                                BlocProvider.of<UsersCubit>(context)
                                    .signIn(Users(
                                        email: emailController.text,
                                        password: passwordController.text))
                                    .whenComplete(() {
                                  setState(() {
                                    _loading = false;
                                  });
                                });
                              } catch (e) {
                                final snackbar =
                                    SnackBar(content: Text(e.toString()));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackbar);
                                setState(() {
                                  _loading = false;
                                });
                              }
                            }

                            FocusScope.of(context).unfocus();
                          },
                          child: const Text('Sign in')),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
