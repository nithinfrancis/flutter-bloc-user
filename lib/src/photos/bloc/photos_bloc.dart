import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_shopping_cart/service/api/api_manager.dart';
import 'package:flutter_shopping_cart/src/photos/models/rm_photos.dart';
import 'package:meta/meta.dart';

import '../../../shopping_repository.dart';
import '../photos.dart';

part 'photos_event.dart';
part 'photos_state.dart';

class PhotosBloc extends Bloc<PhotosEvent, PhotosState> {
  PhotosBloc() : super(PhotosLoading()) {
    on<PhotosStarted>(_onStarted);
  }

  void _onStarted(PhotosStarted event, Emitter<PhotosState> emit) async {
    emit(PhotosLoading());
    try {
      final items = await APIManager().getPhotosById(event.id.toString());
      emit(PhotosLoaded(photos: Photos(items: [...items])));
    } catch (_) {
      emit(PhotosError());
    }
  }
}
