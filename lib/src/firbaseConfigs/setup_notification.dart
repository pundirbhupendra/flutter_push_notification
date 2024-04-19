import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../bloc/notification_bloc.dart';
import '../bloc/notification_state.dart';

class NotificationService {
  static NotificationService? _instance;

  // Private constructor
  NotificationService._internal();

  // Factory constructor with lazy initialization
  factory NotificationService() {
    _instance ??= NotificationService._internal();
    return _instance!;
  }
  Future<void> requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print('User granted permission');
      }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
        print('User granted provisional permission');
      }
    } else {
      if (kDebugMode) {
        print('User declined or has not accepted permission');
      }
    }
    setupLocalNotifications();
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void setupLocalNotifications() async {
    //android 13 heigher

    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('logo');

    InitializationSettings initializationSettings =
        const InitializationSettings(
      android: initializationSettingsAndroid,
    );
    //api leve 26
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
    );
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    if (Platform.isIOS) {
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void setupFCM(BuildContext context) {
    //To handle messages whilst the app is in the background or terminated.
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      var notification = message.notification;
      var android = message.notification?.android;
      if (notification != null && android != null) {
        context.read<NotificationBloc>().add(
              NotificationReceived(
                  title: notification.title ?? "No Title",
                  body: notification.body ?? "No Body"),
            );
      }
    });
    //If your app is opened via a notification whilst the app is terminated.
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      var notification = message.notification;
      if (notification != null) {
        context.read<NotificationBloc>().add(
              NotificationReceived(
                  title: notification.title ?? "No Title",
                  body: notification.body ?? "No Body"),
            );
      }
    });
  }

  Future<void> showNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: false,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      title,
      body,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }
}
