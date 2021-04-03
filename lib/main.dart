import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:messenger/src/app_theme.dart';
import 'package:messenger/src/ui/menu/main_screen.dart';
import 'package:messenger/src/ui/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isLoginPage;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getString("name") != null) {
    isLoginPage = true;
  } else {
    isLoginPage = false;
  }

  await SystemChrome.setPreferredOrientations(
    <DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  ).then(
    (_) => runApp(MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness:
            Platform.isAndroid ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarDividerColor: Colors.grey.withOpacity(0.1),
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zgram',
      theme: ThemeData(
        accentColor: Color(0xFF327FEB),
        canvasColor: Colors.transparent,
        textTheme: AppTheme.textTheme,
        platform: TargetPlatform.iOS,
      ),
      home: isLoginPage ? MainScreen() : OnBoarding(),
    );
  }
}
