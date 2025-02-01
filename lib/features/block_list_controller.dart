import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:website_blocker_desktop/providers/shared_preferences_provider.dart';

final blockListControllerProvider =
    StateNotifierProvider<BlockListController, List<String>>((ref) {
  return BlockListController(ref);
});

class BlockListController extends StateNotifier<List<String>> {
  BlockListController(this.ref) : super([]) {
    state = prefs.getWebsiteList();
  }

  final Ref ref;
  SharedPreferencesService get prefs => ref.read(sharedPreferencesProvider);

  void setWebsiteList(List<String> value) {
    prefs.setWebsiteList(value);
    state = value;
  }
}
