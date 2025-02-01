import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:website_blocker_desktop/features/block_list_controller.dart';
import 'package:website_blocker_desktop/hosts_manager.dart';
import 'package:website_blocker_desktop/providers/shared_preferences_provider.dart';
import 'package:website_blocker_desktop/router/app_router.dart';

final editListControllerProvider =
    StateNotifierProvider<EditListController, AsyncValue>((ref) {
  return EditListController(ref);
});

class EditListController extends StateNotifier<AsyncValue> {
  EditListController(this.ref) : super(AsyncData(null));

  final Ref ref;
  SharedPreferencesService get prefs => ref.read(sharedPreferencesProvider);
  GoRouter get router => ref.read(goRouterProvider);

  Future<void> updateList(String input) async {
    try {
      state = AsyncLoading();
      final websites = HostsManager.validateWebsites(input);
      await HostsManager.updateBlockedWebsites(websites);
      ref.read(blockListControllerProvider.notifier).setWebsiteList(websites);
      router.pop();
    } catch (e, st) {
      state = AsyncError(e, st);
    } finally {
      state = AsyncData(null);
    }
  }
}
