import 'package:equatable/equatable.dart';
import 'package:technical_test_meddi_yosidey/models/hospital/hospital_model.dart';

abstract class HospitalState extends Equatable {
  const HospitalState();

  @override
  List<Object> get props => [];
}

class HospitalInitialState extends HospitalState {}

class HospitalLoadingState extends HospitalState {}

class HospitalReceivedState extends HospitalState {
  final ResponseHospital responseHospital;

  const HospitalReceivedState({required this.responseHospital});
}

class HospitalSuccessState extends HospitalState {}

class HospitalFailedState extends HospitalState {
  final error;

  const HospitalFailedState({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => "HospitalFailedState { error: $error }";
}
