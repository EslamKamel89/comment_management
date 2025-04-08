import 'package:comment_management/features/comments_info/entities/comment_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CommentCard extends StatelessWidget {
  final CommentEntity comment;

  const CommentCard({super.key, required this.comment});

  // Helper method returns badge color based on status
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'accepted':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      case 'waiting':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Comment Creator and Associated Ayah/Tag/Article
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(comment.creator, style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  comment.associated,
                  // style: Theme.of(context).textTheme.caption,
                ),
              ],
            ).animate().fadeIn(duration: 400.ms),
            const SizedBox(height: 8),
            // Comment content
            Text(
              comment.content,
              // style: Theme.of(context).textTheme.bodyText2,
            ).animate().fadeIn(duration: 400.ms),
            const SizedBox(height: 8),
            // Status badge and creation date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Status badge with colored background
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(comment.status),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    comment.status.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ).animate().fadeIn(duration: 400.ms),
                // Comment creation date
                Text(
                  "${comment.createdAt.toLocal()}".split(' ')[0],
                  // style: Theme.of(context).textTheme.caption,
                ).animate().fadeIn(duration: 400.ms),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
