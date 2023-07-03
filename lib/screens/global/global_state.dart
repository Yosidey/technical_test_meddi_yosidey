import 'package:equatable/equatable.dart';

abstract class GlobalState extends Equatable {
  const GlobalState();

  @override
  List<Object> get props => [];
}

class GlobalInitialState extends GlobalState {}

class GlobalAuthenticationAuthenticatedState extends GlobalState {}
class GlobalAuthenticationUnauthenticatedState extends GlobalState {}


class GlobalUnauthenticatedState extends GlobalState {}

