import 'package:equatable/equatable.dart';
import 'package:technical_test_meddi_yosidey/models/user/user_model.dart';

abstract class GlobalEvent extends Equatable {
  const GlobalEvent();

  @override
  List<Object> get props => [];
}

class GlobalCheckAuthenticationEvent extends GlobalEvent {}

class GlobalPersistTokenEvent extends GlobalEvent {
  final ResponseUserLogin responseLogin;
  const GlobalPersistTokenEvent({required this.responseLogin});
}

class GlobalDeleteTokenEvent extends GlobalEvent {}
