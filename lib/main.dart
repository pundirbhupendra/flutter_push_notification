import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_push_notification/src/bloc/notification_bloc.dart';
import 'src/firbaseConfigs/fir_confis.dart';
import 'src/firbaseConfigs/setup_notification.dart';
import 'src/home/home_page.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  if (kDebugMode) {
    print('A new onMessageOpenedApp event was published!');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  if (kDebugMode) {
    final fcmToken = await FirebaseMessaging.instance.getToken();

    debugPrint(fcmToken);
  }

  //Notification handler funcs ragister
  NotificationService().requestPermission();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const NotificationSetup(),
      ),
    );
  }
}

class NotificationSetup extends StatefulWidget {
  const NotificationSetup({super.key});

  @override
  State<NotificationSetup> createState() => _NotificationSetupState();
}

class _NotificationSetupState extends State<NotificationSetup> {
  @override
  void initState() {
    super.initState();
    NotificationService().setupFCM(context);
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      body: const MyHomePage(title: 'Flutter Demo Notification'),
    );
  }
}
