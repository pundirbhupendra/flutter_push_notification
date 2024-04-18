import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

mixin NotificationSetUp {
  late AndroidNotificationChannel channel;
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();

  Future<void> setupFlutterNotifications() async {
    // if (_isFlutterLocalNotificationsInitialized) return;

    channel = const AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );

    //android 13 heigher

    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    // await flutterLocalNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<
    //         AndroidFlutterLocalNotificationsPlugin>()
    //     ?.createNotificationChannel(channel);

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      // iOS: initializationSettingsDarwin,
      // macOS: initializationSettingsDarwin,
      // linux: initializationSettingsLinux,
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    if (Platform.isIOS) {
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  showNotification() {
    // flutterLocalNotificationsPlugin.show(
    //     channel.hashCode,
    //     'title',
    //     'body',
    //     NotificationDetails(
    //         android: AndroidNotificationDetails(channel.id, channel.name,
    //             channelDescription: channel.description)));
  }
}
