import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:website_blocker_desktop/router/app_router.dart';

class WebsiteBlockerApp extends ConsumerWidget {
  const WebsiteBlockerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      title: 'Website Blocker',
      theme: ThemeData(
        fontFamily: 'Inter',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: WidgetStateProperty.all(Colors.blueGrey.shade400),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color.fromARGB(255, 237, 244, 252),
          surfaceTintColor: const Color.fromARGB(255, 237, 244, 252),
          foregroundColor: Colors.black,
          shadowColor: Colors.black,
          shape: const Border(bottom: BorderSide(color: Colors.black12)),
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 237, 244, 252),
      ),
    );
  }
}
