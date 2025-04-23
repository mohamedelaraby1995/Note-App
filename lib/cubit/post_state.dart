class PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  // List of posts
  final List<dynamic> posts;

  PostLoaded(this.posts);
}

class PostError extends PostState {
  /// Error message

  final String message;
  PostError(this.message);
}
