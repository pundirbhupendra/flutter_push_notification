import 'package:bloc/bloc.dart';
import 'package:flutter_push_notification/src/bloc/notification_event.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial()) {
    on<NotificationReceived>((event, emit) {
      emit(NotificationLoaded(title: event.title, body: event.body));
    });
  }
}
