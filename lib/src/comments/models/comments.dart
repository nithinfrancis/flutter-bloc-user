import 'package:equatable/equatable.dart';
import 'package:flutter_shopping_cart/src/comments/models/rm_comment.dart';


class Comments extends Equatable {
  Comments({required this.commentList});

  final List<RMComment> commentList;

  @override
  List<Object> get props => [commentList];
}
