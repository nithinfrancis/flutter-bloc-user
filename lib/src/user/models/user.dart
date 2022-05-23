import 'package:equatable/equatable.dart';

import 'rm_user.dart';

class User extends Equatable {
  User({required this.userList});

  final List<RMUser> userList;

  @override
  List<Object> get props => [userList];
}
