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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAaZIx9uJ-3xFThVlG2WxikevOcxM-uEM0',
    appId: '1:1064418391353:web:a1f219abe1afd72ae7a4e8',
    messagingSenderId: '1064418391353',
    projectId: 'incomey-7b728',
    authDomain: 'incomey-7b728.firebaseapp.com',
    storageBucket: 'incomey-7b728.appspot.com',
    measurementId: 'G-9JQZD76SK3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD_-0IFpXlRebIWz80ngu3smtSXG4NURd4',
    appId: '1:1064418391353:android:475eacc30b58b1ede7a4e8',
    messagingSenderId: '1064418391353',
    projectId: 'incomey-7b728',
    storageBucket: 'incomey-7b728.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAjuD6exmwKYvfJZb8TSkp9hlPWTjU_r-s',
    appId: '1:1064418391353:ios:c2c677bb92412172e7a4e8',
    messagingSenderId: '1064418391353',
    projectId: 'incomey-7b728',
    storageBucket: 'incomey-7b728.appspot.com',
    iosClientId: '1064418391353-idpmeeob2sh9upns1c3il5vvafmgraea.apps.googleusercontent.com',
    iosBundleId: 'com.example.incomey',
  );
}