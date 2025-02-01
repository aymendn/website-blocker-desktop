import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'package:website_blocker_desktop/app.dart';
import 'package:website_blocker_desktop/providers/shared_preferences_provider.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Must add this line.
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = WindowOptions(
    size: Size(400, 500),
    center: true,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
    title: 'Website Blocker',
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  // * Initialize shared preferences
  await SharedPreferencesService.init();

  // * Make GoRouter's push and pop methods work on web urls
  GoRouter.optionURLReflectsImperativeAPIs = true;

  // * turn off the # in the URLs on the web
  usePathUrlStrategy();

  runApp(
    ProviderScope(
      child: ScreenUtilInit(
        designSize: const Size(430, 932),
        builder: (_, __) => const WebsiteBlockerApp(),
      ),
    ),
  );
}
