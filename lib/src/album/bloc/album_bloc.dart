import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_shopping_cart/service/api/api_manager.dart';
import 'package:flutter_shopping_cart/src/album/models/rm_album.dart';
import 'package:meta/meta.dart';

import '../../../shopping_repository.dart';
import '../album.dart';

part 'album_event.dart';
part 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  AlbumBloc() : super(AlbumLoading()) {
    on<AlbumStarted>(_onStarted);
  }


  void _onStarted(AlbumStarted event, Emitter<AlbumState> emit) async {
    emit(AlbumLoading());
    try {
      final items = await APIManager().getAlbumsById(event.id.toString());
      emit(AlbumLoaded(album: Album(items: [...items])));
    } catch (_) {
      emit(AlbumError());
    }
  }
}
