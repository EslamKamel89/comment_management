import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CommentCard extends StatelessWidget {
  final String title;
  final int allCount;
  final int acceptedCount;
  final int rejectedCount;
  final int waitingCount;

  const CommentCard({
    super.key,
    required this.title,
    required this.allCount,
    required this.acceptedCount,
    required this.rejectedCount,
    required this.waitingCount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 6,
      shadowColor: Colors.black26,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(border: Border(right: BorderSide(color: Colors.grey))),
                padding: EdgeInsets.only(right: 15),
                child: Text(
                      title,
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
                    )
                    .animate()
                    .fadeIn(duration: 500.ms)
                    .slideY(begin: 10, end: 0, curve: Curves.easeOut),
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Title of the card with its own animation
                  const SizedBox(height: 12),
                  // Row for all counts
                  _buildInfoRow('All Comments', allCount, context, 1),
                  const SizedBox(height: 8),
                  // Row for accepted counts
                  _buildInfoRow('Accepted', acceptedCount, context, 2),
                  const SizedBox(height: 8),
                  // Row for rejected counts
                  _buildInfoRow('Rejected', rejectedCount, context, 3),
                  const SizedBox(height: 8),
                  // Row for waiting counts
                  _buildInfoRow('Waiting', waitingCount, context, 4),
                ],
              ),
            ),
          ],
        ),
      ),
      // .animate(
      //   // Animate the entire card with slight scaling and fading
      //   effects: [
      //     FadeEffect(duration: 700.ms),
      //     ScaleEffect(
      //       duration: 700.ms,
      //       begin: Offset(0.8, 0.8),
      //       end: Offset(1, 1),
      //       curve: Curves.easeOut,
      //     ),
      //   ],
      // ),
    );
  }

  Widget _buildInfoRow(String label, int count, BuildContext context, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        Text(
          '$count',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    ).animate(effects: [FadeEffect(duration: (500 * index).ms)]);
  }
}
