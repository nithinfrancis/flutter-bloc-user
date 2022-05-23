import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_shopping_cart/service/api/api_manager.dart';
import 'package:flutter_shopping_cart/shopping_repository.dart';
import 'package:meta/meta.dart';

import '../post.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostLoading()) {
    on<PostStarted>(_onStarted);
  }


  void _onStarted(PostStarted event, Emitter<PostState> emit) async {
    emit(PostLoading());
    try {
      final items = await APIManager().getPostsById(event.id.toString());
      emit(PostLoaded(cart: Post(items: [...items])));
    } catch (_) {
      emit(PostError());
    }
  }
}
