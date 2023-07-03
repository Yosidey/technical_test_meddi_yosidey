import 'package:equatable/equatable.dart';
import 'package:technical_test_meddi_yosidey/models/user/user_model.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserLoginInEvent extends UserEvent {
  final UserLogin user;

  const UserLoginInEvent({required this.user});
}

class UserLoginOutEvent extends UserEvent {}

class UserCreateEvent extends UserEvent {
  final UserCreate user;
  const UserCreateEvent({required this.user});
}
