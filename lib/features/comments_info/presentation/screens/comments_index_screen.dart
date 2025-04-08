import 'package:comment_management/features/comments_info/entities/comment_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CommentsIndexScreen extends StatefulWidget {
  const CommentsIndexScreen({super.key});

  @override
  State<CommentsIndexScreen> createState() => _CommentsIndexScreenState();
}

class _CommentsIndexScreenState extends State<CommentsIndexScreen> {
  List<CommentEntity> allComments = [];
  List<CommentEntity> filteredComments = [];
  String searchQuery = '';
  String? selectedStatus;
  String selectedSort = 'latest';

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Create some sample comments
    allComments = [
      CommentEntity(
        creator: 'Ali',
        associated: 'Ayat 2:255',
        content:
            'Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit',
        status: 'accepted',
        createdAt: DateTime.now().subtract(const Duration(minutes: 15)),
      ),
      CommentEntity(
        creator: 'Fatima',
        associated: 'Article on Faith',
        content:
            'Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit',
        status: 'waiting',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      CommentEntity(
        creator: 'Omar',
        associated: 'Tag: Reflection',
        content:
            'Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit',
        status: 'rejected',
        createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
      ),
      CommentEntity(
        creator: 'Zainab',
        associated: 'Ayat 3:18',
        content:
            'Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit',
        status: 'accepted',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
    ];

    // Initially, no status filter is applied (or you can use an "All" option)
    selectedStatus = null;
    // Filter and sort the comments at startup.
    _filterComments();
  }

  void _filterComments() {
    List<CommentEntity> comments = allComments;

    // Apply search filter (searching in creator name and comment content)
    if (searchQuery.isNotEmpty) {
      comments =
          comments.where((c) {
            return c.creator.toLowerCase().contains(searchQuery.toLowerCase()) ||
                c.content.toLowerCase().contains(searchQuery.toLowerCase());
          }).toList();
    }

    // Filter by status if one is selected (note: an empty string or null means no filter)
    if (selectedStatus != null && selectedStatus!.isNotEmpty) {
      comments =
          comments.where((c) => c.status.toLowerCase() == selectedStatus!.toLowerCase()).toList();
    }

    // Sort the list by date. Latest means most recent first.
    comments.sort((a, b) {
      if (selectedSort == 'latest') {
        return b.createdAt.compareTo(a.createdAt);
      } else {
        return a.createdAt.compareTo(b.createdAt);
      }
    });

    setState(() {
      filteredComments = comments;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("All Comments"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Filters and sort section
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    // SEARCH TEXT FIELD
                    TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        labelText: 'Search comments',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                      ),
                      onChanged: (value) {
                        searchQuery = value;
                        _filterComments();
                      },
                    ).animate().fadeIn(duration: 500.ms),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        // DROP DOWN TO FILTER BY STATUS
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: 'Filter by status',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                            ),
                            // You can set the value to an empty string to indicate "All"
                            value: selectedStatus,
                            items: [
                              const DropdownMenuItem(value: 'accepted', child: Text('Accepted')),
                              const DropdownMenuItem(value: 'rejected', child: Text('Rejected')),
                              const DropdownMenuItem(value: 'waiting', child: Text('Waiting')),
                              const DropdownMenuItem(value: '', child: Text('All')),
                            ],
                            onChanged: (value) {
                              setState(() {
                                // When "All" is selected, remove the status filter.
                                if (value == '') {
                                  selectedStatus = null;
                                } else {
                                  selectedStatus = value;
                                }
                                _filterComments();
                              });
                            },
                          ).animate().fadeIn(duration: 600.ms),
                        ),
                        const SizedBox(width: 12),
                        // DROP DOWN TO SORT BY DATE
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: 'Sort by date',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                            ),
                            value: selectedSort,
                            items: const [
                              DropdownMenuItem(value: 'latest', child: Text('Latest')),
                              DropdownMenuItem(value: 'oldest', child: Text('Oldest')),
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedSort = value ?? 'latest';
                                _filterComments();
                              });
                            },
                          ).animate().fadeIn(duration: 600.ms),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ).animate().fadeIn(duration: 700.ms),
            const SizedBox(height: 16),
            // COMMENTS LIST SECTION
            Expanded(
              child:
                  filteredComments.isNotEmpty
                      ? ListView.builder(
                        itemCount: filteredComments.length,
                        itemBuilder: (context, index) {
                          final comment = filteredComments[index];
                          return CommentCard(
                            comment: comment,
                          ).animate().fadeIn(duration: 500.ms, delay: (index * 100).ms);
                        },
                      )
                      : const Center(child: Text("No comments found")),
            ),
          ],
        ),
      ),
    );
  }
}

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
