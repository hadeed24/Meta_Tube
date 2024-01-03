import 'package:flutter/material.dart';
import 'package:meta_tube/Screens/splash_screen.dart';
import 'package:window_manager/window_manager.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  WindowOptions windowOptions = const WindowOptions(
    minimumSize: Size(400, 850),
    size: Size(600, 850),
    center: true,
    title: "MetaTube",
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
}
