part of 'comments_bloc.dart';

abstract class CommentsState extends Equatable {
  const CommentsState();

  @override
  List<Object> get props => [];
}

class CommentsLoading extends CommentsState {}

class CommentsLoaded extends CommentsState {
  const CommentsLoaded();

  static Map<int,Comments> commentMap={};

  static addComments(int key,Comments comments){
    commentMap[key]=comments;
  }

  @override
  List<Object> get props => [commentMap];
}

class CommentsError extends CommentsState {}
