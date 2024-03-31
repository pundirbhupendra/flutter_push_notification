import 'package:bloc/bloc.dart';
import 'package:flutter_push_notification/src/bloc/notification_event.dart';

import '../firbaseConfigs/setup_notification.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState>
    with NotificationSetUp {
  /// {@macro counter_bloc}
  NotificationBloc() : super(NotificationInitState()) {
    on<NotificationReceivedEvent>(
        (event, emit) => _getNotification(event, emit));
  }

  _getNotification(
      NotificationReceivedEvent event, Emitter<NotificationState> emit) {
    //show to ui
    showNotification();
  }
}
