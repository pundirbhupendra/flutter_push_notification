import 'package:firebase_messaging/firebase_messaging.dart';

abstract class NotificationEvent {}

class NotificationReceivedEvent extends NotificationEvent {
  NotificationReceivedEvent({this.event});
  RemoteMessage? event;
}
