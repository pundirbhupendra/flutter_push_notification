abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationLoaded extends NotificationState {
  final String title;
  final String body;

  NotificationLoaded({required this.title, required this.body});
}
