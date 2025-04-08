import 'package:comment_management/core/router/app_routes_names.dart';
import 'package:comment_management/features/comments_info/presentation/widgets/comment_info_card.dart';
import 'package:flutter/material.dart';

class CommentsInfoScreen extends StatefulWidget {
  const CommentsInfoScreen({super.key});

  @override
  State<CommentsInfoScreen> createState() => _CommentsInfoScreenState();
}

class _CommentsInfoScreenState extends State<CommentsInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Comment Manager'), centerTitle: true, elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // "Ayat" Card
            CommentInfoCard(
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutesNames.commentsIndexScreen);
              },
              title: 'Ayat',
              allCount: 120,
              acceptedCount: 90,
              rejectedCount: 10,
              waitingCount: 20,
            ),
            const SizedBox(height: 16),
            // "Articles" Card
            CommentInfoCard(
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutesNames.commentsIndexScreen);
              },
              title: 'Articles',
              allCount: 200,
              acceptedCount: 150,
              rejectedCount: 25,
              waitingCount: 25,
            ),
            const SizedBox(height: 16),
            // "Comments" Card
            CommentInfoCard(
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutesNames.commentsIndexScreen);
              },
              title: 'Tags',
              allCount: 350,
              acceptedCount: 300,
              rejectedCount: 30,
              waitingCount: 20,
            ),
          ],
        ),
        // .animate(
        //   // Animate the entry of the whole column
        //   effects: [
        //     SlideEffect(
        //       begin: const Offset(0, 1),
        //       end: Offset.zero,
        //       curve: Curves.easeOut,
        //       duration: 600.ms,
        //     ),
        //     FadeEffect(curve: Curves.easeIn, duration: 600.ms),
        //   ],
        // ),
      ),
    );
  }
}
