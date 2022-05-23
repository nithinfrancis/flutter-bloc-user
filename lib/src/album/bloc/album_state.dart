part of 'album_bloc.dart';

@immutable
abstract class AlbumState extends Equatable {
  const AlbumState();
}

class AlbumLoading extends AlbumState {
  @override
  List<Object> get props => [];
}

class AlbumLoaded extends AlbumState {
  const AlbumLoaded({this.album = const Album()});

  final Album album;

  @override
  List<Object> get props => [album];
}

class AlbumError extends AlbumState {
  @override
  List<Object> get props => [];
}
