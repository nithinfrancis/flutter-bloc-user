import 'package:equatable/equatable.dart';
import 'package:flutter_shopping_cart/src/album/models/rm_album.dart';

class Album extends Equatable {
  const Album({this.items = const <RMAlbum>[]});

  final List<RMAlbum> items;

  int get totalPrice {
    return items.fold(0, (total, current) => 0);
  }

  @override
  List<Object> get props => [items];
}
