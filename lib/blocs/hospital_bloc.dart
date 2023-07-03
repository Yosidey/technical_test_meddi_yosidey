import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_test_meddi_yosidey/blocs/blocs_export.dart';
import 'package:technical_test_meddi_yosidey/screens/global/global_export.dart';
import 'package:technical_test_meddi_yosidey/screens/hospital/hospital_export.dart';
import 'package:technical_test_meddi_yosidey/services/helpers/exceptions.dart';
import 'package:technical_test_meddi_yosidey/services/requests/hospital_request.dart';

class HospitalBloc extends Bloc<HospitalEvent, HospitalState> {
  final GlobalBloc globalBloc;

  /// Initial default state
  @override
  HospitalBloc({required this.globalBloc}) : super(HospitalInitialState());

  /// Initial default state
  HospitalState get initialState => HospitalInitialState();

  @override
  Stream<HospitalState> mapEventToState(HospitalEvent event) async* {
    final request = HospitalRequest();
    try {
      if (event is HospitalGetDataEvent) {
        yield HospitalLoadingState();
        yield HospitalReceivedState(responseHospital: await request.getHospitals(event.page));
        yield HospitalSuccessState();
      }
      if (event is HospitalRequestEvent) {
        yield HospitalLoadingState();
        await request.requestsHospital(event.hospital);
        yield HospitalSuccessState();
      }
    } on UnauthorizedDataException {
      globalBloc.add(GlobalDeleteTokenEvent());
      globalBloc.add(GlobalCheckAuthenticationEvent());
      yield HospitalFailedState(error: UnauthorizedDataException());
    } catch (error) {
      yield HospitalFailedState(error: error.toString());
    }
  }
}
