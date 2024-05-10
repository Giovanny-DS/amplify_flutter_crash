import 'dart:io';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:amplifycrashtest/main_common.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // UNCOMMENT THIS CODE TO ENABLE CRASHLYTICS
  // if (!kIsWeb) {
  //   FlutterError.onError = (FlutterErrorDetails errorDetails) {
  //     FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  //   };

  //   // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  //   PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
  //     FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);

  //     return true;
  //   };
  // }

  HttpOverrides.global = MyHttpOverrides();

  mainCommon();
}

/// Allows error-free http requests on iOS in debug mode.
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
