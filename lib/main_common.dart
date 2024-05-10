import 'dart:async';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:amplifycrashtest/amplifyconfiguration.dart';
import 'package:amplifycrashtest/src/config/bloc_config.dart';

import 'src/app.dart';

/// Init configuration before run app
Future<void> mainCommon() async {
  /// If it is mobile, it validates if the device is rooted and closes the application.
  if (!kIsWeb) {
    final bool jailbroken = await FlutterJailbreakDetection.jailbroken;

    if (jailbroken) {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      return;
    }
  }

  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  if (await Hive.boxExists('encryptionKeyBox')) {
    if (!Hive.isBoxOpen('encryptionKeyBox')) {
      await Hive.openBox('encryptionKeyBox');
      if (!Hive.isBoxOpen('vaultBox')) {
        final Box<dynamic> vaultBox = await Hive.openBox('vaultBox', encryptionCipher: HiveAesCipher(Hive.box('encryptionKeyBox').get('key')));
        Get.put<Box<dynamic>>(vaultBox);
      }
    }
  } else {
    final Box<dynamic> keyBox = await Hive.openBox('encryptionKeyBox');
    final List<int> key = Hive.generateSecureKey();
    keyBox.put('key', key);
    final Box<dynamic> vaultBox = await Hive.openBox('vaultBox', encryptionCipher: HiveAesCipher(key));
    Get.put<Box<dynamic>>(vaultBox);
  }

  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[DeviceOrientation.portraitUp]);

  // ignore: prefer_const_constructors
  setUrlStrategy(PathUrlStrategy());

  Bloc.observer = BlocConsoleDebugPrinter();

  await _configureAmplify();

  runApp(const App());
}

/// Configure amplify AWS plugins
Future<void> _configureAmplify() async {
  try {
    final AmplifyAuthCognito auth = AmplifyAuthCognito();
    await Amplify.addPlugin(auth);
    await Amplify.configure(amplifyconfig);
  } on Exception catch (e) {
    safePrint('An error occurred configuring Amplify: $e');
  }
}
