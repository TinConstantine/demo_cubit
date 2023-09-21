import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinity_list_cubit/services/comments_service.dart';
import 'package:infinity_list_cubit/states/comments_state.dart';

// ignore: constant_identifier_names
const NUMBER_OF_COMMENT_PER_PAGE = 20;

class CommentCubit extends Cubit<CommentState> {
  CommentCubit() : super(CommentStateInitial());
  void loadComment() async {
    if (!(state is CommentStateSuccess &&
        (state as CommentStateSuccess).hasReachedEnd)) {
      try {
        if (state is CommentStateInitial) {
          final comments =
              await getCommentFromApi(0, NUMBER_OF_COMMENT_PER_PAGE);

          emit(CommentStateSuccess(comments: comments, hasReachedEnd: false));
        } else if (state is CommentStateSuccess) {
          final currentState = state as CommentStateSuccess;
          int finalIndexOfCurrentPage = currentState.comments.length;
          final comments = await getCommentFromApi(
              finalIndexOfCurrentPage, NUMBER_OF_COMMENT_PER_PAGE);

          if (comments.isEmpty) {
            emit(currentState.cloneWith(hasReachedEnd: true));
          } else {
            emit(currentState.cloneWith(
                comments: currentState.comments + comments,
                hasReachedEnd: false));
          }
        }
      } catch (e) {
        emit(CommentStateFailure());
      }
    }
  }
}
