part of 'post_bloc.dart';


@immutable
abstract class PostState extends Equatable {
  const PostState();
}

class PostLoading extends PostState {
  @override
  List<Object> get props => [];
}

class PostLoaded extends PostState {
  const PostLoaded({this.cart = const Post()});

  final Post cart;

  @override
  List<Object> get props => [cart];
}

class PostError extends PostState {
  @override
  List<Object> get props => [];
}
