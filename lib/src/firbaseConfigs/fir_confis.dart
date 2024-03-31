import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBUBswjxYmDnWU4UDHMWrljrp5iQINL6to',
    appId: '1:921120448180:android:f916648787a7296b6581e1',
    messagingSenderId: '921120448180',
    projectId: 'notification-70681',
    //  storageBucket: 'ipijobs-notifications.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBUBswjxYmDnWU4UDHMWrljrp5iQINL6to',
    appId: '1:921120448180:android:f916648787a7296b6581e1',
    messagingSenderId: '921120448180',
    projectId: 'notification-70681',
    // storageBucket: 'ipijobs-notifications.appspot.com',
    //  iosBundleId: 'com.lipijobs.userapp', //com.lipijobs.app.lipijobs
    //  iosClientId:
    //  '172374588984-a2rf6o05jujvb6f0m4e22uaqlcieqsm1.apps.googleusercontent.com'
  );
}
