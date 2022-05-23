import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_shopping_cart/service/api/api_manager.dart';
import 'package:flutter_shopping_cart/shopping_repository.dart';

import '../comments.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  CommentsBloc() : super(CommentsLoading()) {
    on<CommentsStarted>(_onStarted);
  }



  void _onStarted(CommentsStarted event, Emitter<CommentsState> emit) async {
    emit(CommentsLoading());
    try {
      final comments = await APIManager().getCommentsById(event.postId.toString());
      CommentsLoaded.commentMap[event.postId]=Comments(
        commentList: comments
      );
      emit(CommentsLoaded());
    } catch (_) {
      emit(CommentsError());
    }
  }
}
