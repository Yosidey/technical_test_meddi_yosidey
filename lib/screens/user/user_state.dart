import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class UserReceivedState extends UserState {}

class UserSuccessState extends UserState {}

class UserFailedState extends UserState {
  final error;
  const UserFailedState({required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => "UserFailedState { error: $error }";
}
