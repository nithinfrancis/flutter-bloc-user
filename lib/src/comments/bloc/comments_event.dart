part of 'comments_bloc.dart';


abstract class CommentsEvent extends Equatable {
  const CommentsEvent();
}

class CommentsStarted extends CommentsEvent {

  const CommentsStarted(this.postId);

  final int postId;

  @override
  List<Object> get props => [];
}
