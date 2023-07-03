import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_test_meddi_yosidey/screens/global/global_export.dart';
import 'package:technical_test_meddi_yosidey/services/storage/user_storage.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  GlobalBloc() : super(GlobalInitialState());

  GlobalState get initialState => GlobalInitialState();

  @override
  Stream<GlobalState> mapEventToState(GlobalEvent event) async* {
    final storage = UserStorage();
    if (event is GlobalCheckAuthenticationEvent) {
      if (await storage.hasToken()) {
        yield GlobalAuthenticationAuthenticatedState();
      } else {
        yield GlobalAuthenticationUnauthenticatedState();
      }
    }
    if (event is GlobalPersistTokenEvent) {
      await storage.persistToken(event.responseLogin);
    }
    if (event is GlobalDeleteTokenEvent) {
      await storage.deleteToken();
    }
  }
}
