import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:twitter_app/features/domain/entities/tweet.dart';
import 'package:twitter_app/features/presentation/cubit/auth_cubit.dart';
import 'package:twitter_app/features/presentation/cubit/tweet_cubit.dart';
import 'package:twitter_app/features/presentation/pages/main_page.dart';
import 'package:twitter_app/features/presentation/widget/custom_text_field.dart';
import 'package:twitter_app/features/presentation/widget/simple_alert_dialog.dart';

class HomePage extends StatefulWidget {
  final String uid;

  const HomePage({Key? key, required this.uid}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _tweetController = TextEditingController();
  bool _isEdit = false;
  String _tweetId = '';

  @override
  void initState() {
    BlocProvider.of<TweetCubit>(context).fetchTweet(widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Twitter App',
          style: TextStyle(color: Color(0xff1c9aef)),
        ),
        actions: [
          TextButton(
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (context) {
                      return SimpleAlertDialog(
                        title: 'Logout',
                        body: 'Are you sure want to logout?',
                        onTap: () {
                          BlocProvider.of<AuthCubit>(context).logout();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              MainPage.routeName, (route) => false);
                        },
                      );
                    });
              },
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomTextfield(
                textInputMaxLength: 280,
                controller: _tweetController,
                hintText: "What's happening?",
                title: '',
                maxLines: 5,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                  onPressed: () {
                    if (_isEdit) {
                      BlocProvider.of<TweetCubit>(context).updateTweet(Tweet(
                          tweet: _tweetController.text,
                          createdAt: Timestamp.now(),
                          uid: widget.uid,
                          id: _tweetId));

                      setState(() {
                        _isEdit = false;
                      });
                    } else {
                      BlocProvider.of<TweetCubit>(context).addingTweet(Tweet(
                          tweet: _tweetController.text,
                          createdAt: Timestamp.now(),
                          uid: widget.uid));
                    }

                    FocusScope.of(context).unfocus();
                    _tweetController.clear();
                  },
                  child: Text(_isEdit ? 'Update' : 'Submit')),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<TweetCubit, TweetState>(
                builder: (context, state) {
                  if (state is TweetLoaded) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.tweet.length,
                      itemBuilder: (context, index) {
                        final dateFormat = DateFormat.yMMMMd().add_jm();
                        return Card(
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            title: Row(
                              children: [
                                Expanded(
                                    child: Text(state.tweet[index].tweet!)),
                                PopupMenuButton(
                                    onSelected: (value) {
                                      if (value == 0) {
                                        _tweetController.text =
                                            state.tweet[index].tweet!;
                                        setState(() {
                                          _isEdit = true;
                                          _tweetId = state.tweet[index].id!;
                                        });
                                      } else {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return SimpleAlertDialog(
                                                title: 'Delete tweet',
                                                body:
                                                    'Are you sure want to delete this tweet?',
                                                onTap: () {
                                                  BlocProvider.of<TweetCubit>(
                                                          context)
                                                      .removeTweet(
                                                          state.tweet[index])
                                                      .whenComplete(() =>
                                                          Navigator.pop(
                                                              context));
                                                },
                                              );
                                            });
                                      }
                                    },
                                    itemBuilder: (context) => [
                                          const PopupMenuItem(
                                              value: 0, child: Text('Edit')),
                                          const PopupMenuItem(
                                              value: 1, child: Text('Delete'))
                                        ]),
                              ],
                            ),
                            subtitle: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Text(dateFormat.format(
                                    state.tweet[index].createdAt!.toDate()))),
                          ),
                        );
                      },
                    );
                  } else if (state is TweetEmpty) {
                    return SizedBox(
                        height: MediaQuery.of(context).size.height / 3,
                        child: const Center(child: Text('Tweet is empty')));
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
