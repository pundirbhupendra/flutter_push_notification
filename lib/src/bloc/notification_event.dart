abstract class NotificationEvent {}

class NotificationReceived extends NotificationEvent {
  final String title;
  final String body;

  NotificationReceived({required this.title, required this.body});
}
