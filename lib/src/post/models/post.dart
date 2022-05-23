import 'package:equatable/equatable.dart';

import 'rm_post.dart';

class Post extends Equatable {
  const Post({this.items = const <RMPost>[]});

  final List<RMPost> items;

  int get totalPrice {
    return items.fold(0, (total, current) => 0);
  }

  @override
  List<Object> get props => [items];
}
