import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:website_blocker_desktop/features/edit_list/edit_list_screen.dart';
import 'package:website_blocker_desktop/features/home/home_screen.dart';
import 'package:website_blocker_desktop/features/onboarding/onboarding_screen.dart';
import 'package:website_blocker_desktop/providers/shared_preferences_provider.dart';
import 'package:website_blocker_desktop/router/custom_go_route.dart';

enum AppRoute {
  onboarding,
  home,
  editList,
}

final goRouterProvider = Provider<GoRouter>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final isOnboardingSeen = prefs.getIsOnboardingSeen();

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

  return GoRouter(
    initialLocation: isOnboardingSeen ? '/home' : '/onboarding',
    routes: routes,
  );
});
