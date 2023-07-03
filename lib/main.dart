import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_test_meddi_yosidey/bloc_delegates.dart';
import 'package:technical_test_meddi_yosidey/blocs/global_bloc.dart';
import 'package:technical_test_meddi_yosidey/libraries/app_data.dart' as app_data;
import 'package:technical_test_meddi_yosidey/screens/global/global_export.dart';
import 'package:technical_test_meddi_yosidey/screens/hospital/hospital_export.dart';
import 'package:technical_test_meddi_yosidey/screens/user/user_export.dart';
import 'package:technical_test_meddi_yosidey/services/storage/user_storage.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(BlocProvider(
    create: (context) {
      return GlobalBloc()..add(GlobalCheckAuthenticationEvent());
    },
    child: const GlobalPage(),
  ));
}

class GlobalPage extends StatelessWidget {
  const GlobalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: app_data.appTitle,
      debugShowCheckedModeBanner: false,
      home: Stack(
        children: <Widget>[
          BlocBuilder<GlobalBloc, GlobalState>(
            builder: (context, state) {
              if (state is GlobalInitialState) {
                debugPrint("GlobalInitialState");
              }
              if (state is GlobalAuthenticationAuthenticatedState) {
                print("GlobalAuthenticationAuthenticatedState");
                return const HospitalPage();
              }
              if (state is GlobalAuthenticationUnauthenticatedState) {
                print("GlobalAuthenticationUnauthenticatedState");
                return const UserLoginPage();
              }
              return const SizedBox.shrink();
            },
          )
        ],
      ),
    );
  }
}
