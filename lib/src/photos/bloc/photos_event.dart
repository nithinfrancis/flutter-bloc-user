part of 'photos_bloc.dart';

@immutable
abstract class PhotosEvent extends Equatable {
  const PhotosEvent();
}

class PhotosStarted extends PhotosEvent {
  const PhotosStarted(this.id);

  final int id;
  @override
  List<Object> get props => [];
}

class PhotosItemAdded extends PhotosEvent {
  const PhotosItemAdded(this.item);

  final RMPhotos item;

  @override
  List<Object> get props => [item];
}

