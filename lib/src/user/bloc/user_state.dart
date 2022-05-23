
import 'package:equatable/equatable.dart';

import '../user.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  const UserLoaded(this.catalog);

  final User catalog;

  @override
  List<Object> get props => [catalog];
}

class UserError extends UserState {}
