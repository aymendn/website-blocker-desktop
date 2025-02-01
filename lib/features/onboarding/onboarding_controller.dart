import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:website_blocker_desktop/features/onboarding/onboarding_item.dart';
import 'package:website_blocker_desktop/providers/shared_preferences_provider.dart';
import 'package:website_blocker_desktop/router/app_router.dart';

final onboardingIndexProvider =
    StateNotifierProvider<OnboardingController, int>(
  (ref) => OnboardingController(ref),
);

class OnboardingController extends StateNotifier<int> {
  OnboardingController(this.ref) : super(0);

  final Ref ref;

  final pages = [
    OnboardingItem(
      icon: Symbols.block,
      title: 'Block Distracting Websites',
      description:
          'Easily block social media and other time-wasting sites to stay focused on what matters.',
    ),
    OnboardingItem(
      icon: Symbols.schedule,
      title: 'Set Block Schedules',
      description:
          'Create custom schedules to automatically block sites during work hours.',
    ),
    OnboardingItem(
      icon: Symbols.timer,
      title: 'Boost Productivity',
      description:
          'Take control of your time and enhance your productivity by eliminating digital distractions.',
    ),
  ];

  void nextPage() {
    if (state < pages.length - 1) {
      state++;
    } else {
      ref.read(sharedPreferencesProvider).setIsOnboardingSeen(true);
      ref.read(goRouterProvider).goNamed(AppRoute.home.name);
    }
  }
}
