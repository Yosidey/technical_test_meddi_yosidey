import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

///***************************************************************************
/// SimpleBlocDelegate implementation
///***************************************************************************
class SimpleBlocObserver extends BlocObserver {
  @override

  ///*************** onEvent ***************
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);

    /// just to watch what is happening
    debugPrint("##BLOC: Bloc this is the Event -> $event");
  }

  @override

  ///*************** onTransition ***************
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);

    /// just to watch what is happening
    debugPrint("##BLOC: Bloc this is the Transition -> $transition");
  }

  @override

  ///*************** onError ***************
  void onError(BlocBase bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);

    /// just to watch what is happening
    debugPrint("##BLOC: Bloc this is the Error -> $error");
  }
}
