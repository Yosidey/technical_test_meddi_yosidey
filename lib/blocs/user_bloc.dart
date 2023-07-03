import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_test_meddi_yosidey/blocs/blocs_export.dart';
import 'package:technical_test_meddi_yosidey/screens/global/global_events.dart';
import 'package:technical_test_meddi_yosidey/screens/user/user_export.dart';
import 'package:technical_test_meddi_yosidey/services/helpers/exceptions.dart';
import 'package:technical_test_meddi_yosidey/services/requests/user_request.dart';
import 'package:technical_test_meddi_yosidey/services/storage/user_storage.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GlobalBloc globalBloc;

  UserBloc({required this.globalBloc}) : super(UserInitialState());

  UserState get initialState => UserInitialState();

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    final request = UserRequest();
    final storage = UserStorage();
    try {
      if (event is UserLoginInEvent) {
        yield UserLoadingState();
        var response = await request.loginUser(user: event.user);
        storage.persistToken(response);
        globalBloc.add(GlobalCheckAuthenticationEvent());
        yield UserSuccessState();
      }
      if (event is UserLoginOutEvent) {}
      if (event is UserCreateEvent) {
        yield UserLoadingState();
        await request.createUser(user: event.user);
        yield UserSuccessState();
      }
    } on UnauthorizedDataException {
      yield UserFailedState(error: UnauthorizedDataException());
    } catch (error) {
      yield const UserFailedState(error: "Ocurrio un error");
    } finally {}
  }
}
