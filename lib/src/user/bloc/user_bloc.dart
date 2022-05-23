import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_shopping_cart/service/api/api_manager.dart';
import 'package:flutter_shopping_cart/shopping_repository.dart';

import '../user.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserLoading()) {
    on<UserStarted>(_onStarted);
  }

  void _onStarted(UserStarted event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final catalog = await APIManager().getAllUsers();
      emit(UserLoaded(User(userList: catalog)));
    } catch (_) {
      emit(UserError());
    }
  }
}
