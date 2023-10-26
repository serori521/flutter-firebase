// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members, do_not_use_environment, constant_identifier_names
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;

const flavorName = String.fromEnvironment('flavor');

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (flavorName.isEmpty) {
      throw UnsupportedError(
        'No flavor specified. Please specify a flavor with dart-define-from-file.',
      );
    }

    if (kIsWeb) {
      if (flavorName == 'dev') {
        return _dev_web;
      }
      if (flavorName == 'prod') {
        return _prod_web;
      }
      throw UnsupportedError(
        'Flavor $flavorName does not support Web.',
      );
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        throw UnsupportedError(
          'Flavor $flavorName does not support Android.',
        );
      case TargetPlatform.iOS:
        throw UnsupportedError(
         'Flavor $flavorName does not support iOS.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
      // ignore: no_default_cases
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions _dev_web = FirebaseOptions(
    apiKey: 'AIzaSyA6JFQlFxUspYvN4F1DVTVIb2h-ISeoDw4',
    appId: '1:629337054597:web:1f9296495ba47c248df8ec',
    messagingSenderId: '629337054597',
    projectId: 'lyric-generating-music-app-dev',
    authDomain: 'lyric-generating-music-app-dev.firebaseapp.com',
    storageBucket: 'lyric-generating-music-app-dev.appspot.com',
    measurementId: 'G-BBY1C3V6NN',
  );

  static const FirebaseOptions _prod_web = FirebaseOptions(
    apiKey: 'AIzaSyBeTSjiFkaCC2XJIG7nCAjWCAyGfaNqRvM',
    appId: '1:902759825562:web:70b82ddc09848c34731f23',
    messagingSenderId: '902759825562',
    projectId: 'lyric-generating-music-app',
    authDomain: 'lyric-generating-music-app.firebaseapp.com',
    storageBucket: 'lyric-generating-music-app.appspot.com',
    measurementId: 'G-DPQJ3K6EJG',
  );

}

