import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    log('🟢 BLoC Created: ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('🔄 BLoC Change: ${bloc.runtimeType}');
    log('Current State: ${change.currentState}');
    log('Next State: ${change.nextState}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    // log('📢 BLoC Event: ${bloc.runtimeType} -> $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
      log('🔀 BLoC Transition: ${bloc.runtimeType}');
      log('Event: ${transition.event}');
      log('Current State: ${transition.currentState}');
      log('Next State: ${transition.nextState}');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    log('❌ BLoC Error: ${bloc.runtimeType} -> $error');
    log('StackTrace: $stackTrace');
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    log('🔴 BLoC Closed: ${bloc.runtimeType}');
  }
}
