import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:amplifycrashtest/src/hello_world.dart';
import 'package:amplifycrashtest/src/ui/core/theme/ui_constants.dart';
import 'package:amplifycrashtest/src/utils/constants.dart';

/// Setting MaterialApp for the app responsive and routing initialization
class App extends StatefulWidget {
  /// Constructor
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: UIConstants.colorPrimary));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      builder: UIConstants.materialAppResponsiveBuilder,
      title: UIConstants.materialAppTitle,
      theme: UIConstants.materialAppThemeData,
      getPages: [
        GetPage(name: HelloWorld.routeName, page: () => const HelloWorld()),
      ],
      initialRoute: HelloWorld.routeName,
      unknownRoute: GetPage<dynamic>(
        name: HelloWorld.routeName,
        page: () => const HelloWorld(),
      ),
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[
        Locale(englishLanguageCode),
        Locale(spanishLanguageCode),
      ],
    );
  }
}
