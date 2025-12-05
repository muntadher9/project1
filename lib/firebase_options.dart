// File manually generated from firebase CLI outputs.
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

// Default Firebase options for the supported platforms.
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        throw UnsupportedError(
          'Android FirebaseOptions not configured for project test-2a792.',
        );
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'iOS FirebaseOptions not configured for project test-2a792.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'macOS FirebaseOptions not configured for project test-2a792.',
        );
      case TargetPlatform.windows:
      case TargetPlatform.linux:
        throw UnsupportedError(
          'Desktop FirebaseOptions not configured for project test-2a792.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDVQ7diO_wK1xZNzPHy5oCsj_vIzqcSQ_0',
    appId: '1:676307369412:web:33f322e9b4fe7b94c07891',
    messagingSenderId: '676307369412',
    projectId: 'test-2a792',
    authDomain: 'test-2a792.firebaseapp.com',
    storageBucket: 'test-2a792.firebasestorage.app',
    measurementId: 'G-W30NXC8KG5',
  );
}
