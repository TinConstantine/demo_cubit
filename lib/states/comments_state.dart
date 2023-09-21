import '../models/comment.dart';

abstract class CommentState {}

class CommentStateSuccess extends CommentState {
  final List<Comment> comments;
  final bool hasReachedEnd;
  CommentStateSuccess({required this.comments, required this.hasReachedEnd});
  @override
  String toString() {
    return "comments: $comments, hasReachedEnd: $hasReachedEnd";
  }

  // List<Object> get props => [comments, hasReachedEnd];
  CommentStateSuccess cloneWith(
      {List<Comment>? comments, bool? hasReachedEnd}) {
    return CommentStateSuccess(
        comments: comments ?? this.comments,
        hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd);
  }
}

class CommentStateFailure extends CommentState {}

class CommentStateInitial extends CommentState {}
