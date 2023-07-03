import 'package:equatable/equatable.dart';
import 'package:technical_test_meddi_yosidey/models/hospital/hospital_model.dart';

abstract class HospitalEvent extends Equatable {
  const HospitalEvent();

  @override
  List<Object> get props => [];
}

class HospitalGetDataEvent extends HospitalEvent {
  final int page;

  const HospitalGetDataEvent({required this.page});
}

class HospitalRequestEvent extends HospitalEvent{
  final RequestHospital hospital;
  const HospitalRequestEvent({required this.hospital});
}