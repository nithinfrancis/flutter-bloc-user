part of 'album_bloc.dart';

@immutable
abstract class AlbumEvent extends Equatable {
  const AlbumEvent();
}

class AlbumStarted extends AlbumEvent {
  const AlbumStarted(this.id);

  final int id;
  @override
  List<Object> get props => [];
}

class AlbumItemAdded extends AlbumEvent {
  const AlbumItemAdded(this.item);

  final RMAlbum item;

  @override
  List<Object> get props => [item];
}

