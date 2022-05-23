part of 'photos_bloc.dart';

@immutable
abstract class PhotosState extends Equatable {
  const PhotosState();
}

class PhotosLoading extends PhotosState {
  @override
  List<Object> get props => [];
}

class PhotosLoaded extends PhotosState {
  const PhotosLoaded({this.photos = const Photos()});

  final Photos photos;

  @override
  List<Object> get props => [photos];
}

class PhotosError extends PhotosState {
  @override
  List<Object> get props => [];
}
