class CommentEntity {
  final String creator;
  final String associated; // Ayah, tag, or article association
  final String content;
  final String status; // "accepted", "rejected", or "waiting"
  final DateTime createdAt;

  CommentEntity({
    required this.creator,
    required this.associated,
    required this.content,
    required this.status,
    required this.createdAt,
  });
}
