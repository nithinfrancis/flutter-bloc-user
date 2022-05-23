part of 'post_bloc.dart';

@immutable
abstract class PostEvent extends Equatable {
  const PostEvent();
}

class PostStarted extends PostEvent {
  const PostStarted(this.id);

  final int id;
  @override
  List<Object> get props => [];
}
