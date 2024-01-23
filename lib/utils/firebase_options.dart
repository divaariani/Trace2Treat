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
    apiKey: 'AIzaSyCKWtLvqp1Ub6QU7BP9hsAqMkrP4gnnNkA',
    appId: '1:854051286280:web:f3bf02495a472a271310bd',
    messagingSenderId: '854051286280',
    projectId: 'echobytes-kiddovation',
    authDomain: 'echobytes-kiddovation.firebaseapp.com',
    storageBucket: 'echobytes-kiddovation.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCKWtLvqp1Ub6QU7BP9hsAqMkrP4gnnNkA',
    appId: '1:854051286280:android:f3bf02495a472a271310bd',
    messagingSenderId: '854051286280',
    projectId: 'echobytes-kiddovation',
    storageBucket: 'echobytes-kiddovation.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCxTyauAKhNIDX19jmxddnU9VQH2a7AM2o',
    appId: '1:854051286280:ios:f01dd25803478c161310bd',
    messagingSenderId: '854051286280',
    projectId: 'echobytes-kiddovation',
    storageBucket: 'echobytes-kiddovation.appspot.com',
    iosBundleId: 'com.kiddovation.echobytes',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCxTyauAKhNIDX19jmxddnU9VQH2a7AM2o',
    appId: '1:854051286280:ios:f01dd25803478c161310bd',
    messagingSenderId: '854051286280',
    projectId: 'echobytes-kiddovation',
    storageBucket: 'echobytes-kiddovation.appspot.com',
    iosBundleId: 'com.kiddovation.echobytes',
  );
}