import 'package:equatable/equatable.dart';

import 'rm_photos.dart';

class Photos extends Equatable {
  const Photos({this.items = const <RMPhotos>[]});

  final List<RMPhotos> items;

  int get totalPrice {
    return items.fold(0, (total, current) => 0);
  }

  @override
  List<Object> get props => [items];
}
