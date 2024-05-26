// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAtVhrySMu2dQONCvBxdWjX-2G-wF1t_aA',
    appId: '1:127727631385:web:521df7a50f7cb525663e88',
    messagingSenderId: '127727631385',
    projectId: 'yemektarifi-903ed',
    authDomain: 'yemektarifi-903ed.firebaseapp.com',
    storageBucket: 'yemektarifi-903ed.appspot.com',
    measurementId: 'G-DNCFV7WMXD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAAu9sRa9BIH-E6rUtxE-m1Wk_NSNKjHZ0',
    appId: '1:127727631385:android:6c817dbe85495ec6663e88',
    messagingSenderId: '127727631385',
    projectId: 'yemektarifi-903ed',
    storageBucket: 'yemektarifi-903ed.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAl0thuJvJuOW4OSVZ4RQSJ5kgc_eCpaRY',
    appId: '1:127727631385:ios:775a7f114a1a3f1a663e88',
    messagingSenderId: '127727631385',
    projectId: 'yemektarifi-903ed',
    storageBucket: 'yemektarifi-903ed.appspot.com',
    iosBundleId: 'com.example.yemekTarifiUygulama',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAl0thuJvJuOW4OSVZ4RQSJ5kgc_eCpaRY',
    appId: '1:127727631385:ios:ceb8dd9fa39ac21d663e88',
    messagingSenderId: '127727631385',
    projectId: 'yemektarifi-903ed',
    storageBucket: 'yemektarifi-903ed.appspot.com',
    iosBundleId: 'com.example.yemekTarifiUygulama.RunnerTests',
  );
}
