import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:website_blocker_desktop/debug/logger.dart';
import 'package:website_blocker_desktop/features/edit_list/edit_list_screen.dart';
import 'package:website_blocker_desktop/features/home/home_screen.dart';
import 'package:website_blocker_desktop/features/onboarding/onboarding_screen.dart';
import 'package:website_blocker_desktop/router/custom_go_route.dart';
import 'package:website_blocker_desktop/router/route_utils.dart';

enum AppRoute {
  onboarding,
  home,
  editList,
}

final goRouterProvider = Provider<GoRouter>((ref) {
  final routerNotifier = RouterNotifier(ref);

  return GoRouter(
    initialLocation: '/onboarding',
    refreshListenable: routerNotifier,
    routes: routerNotifier.routes,
    redirect: routerNotifier.redirect,
  );
});

class RouterNotifier extends ChangeNotifier {
  RouterNotifier(this.ref) {
    init();
  }
  final Ref ref;
  bool get isLogged {
    return false;
    // return ref.read(tokenControllerProvider) != null;
  }

  void init() {
    // ref.listen(initialRouteProvider, (_, __) {
    //   notifyListeners();
    // });
  }

  FutureOr<String?> redirect(BuildContext context, GoRouterState state) async {
    logger.debug('redirect: ${state.fullPath}');

    if (state.fullPath == null) {
      return null;
    }

    return RouteUtils.redirect(
      path: state.fullPath!,
      name: state.name,
      ref: ref,
    );
  }

  final List<RouteBase> routes = [
    // onboarding
    CustomGoRoute(
      path: '/onboarding',
      name: AppRoute.onboarding.name,
      page: const OnboardingScreen(),
    ),
    // login
    CustomGoRoute(
      path: '/home',
      name: AppRoute.home.name,
      page: const HomeScreen(),
      routes: [
        CustomGoRoute(
          path: '/edit-list',
          name: AppRoute.editList.name,
          page: const EditListScreen(),
        ),
      ],
    ),
  ];
}
