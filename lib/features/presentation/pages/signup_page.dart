import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:twitter_app/features/domain/entities/user.dart';
import 'package:twitter_app/features/presentation/cubit/users_cubit.dart';
import 'package:twitter_app/features/presentation/pages/signin_page.dart';
import 'package:twitter_app/features/presentation/widget/custom_text_field.dart';

class SignUpPage extends StatefulWidget {
  static const routeName = '/sign_up';
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        title: const Text(
          'Sign Up',
        ),
        centerTitle: true,
        elevation: 1,
      ),
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _loading,
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Column(
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
                          if (emailController.text.isNotEmpty &&
                              passwordController.text.isNotEmpty) {
                            setState(() {
                              _loading = true;
                            });
                            try {
                              BlocProvider.of<UsersCubit>(context)
                                  .signUp(Users(
                                      email: emailController.text,
                                      password: passwordController.text))
                                  .whenComplete(() {
                                setState(() {
                                  _loading = false;
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      SignInPage.routeName, (route) => false);
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
                        },
                        child: const Text('Sign up')),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
