import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:website_blocker_desktop/hosts_manager.dart';

final blockListControllerProvider =
    StateNotifierProvider<BlockListController, List<String>>((ref) {
  return BlockListController();
});

class BlockListController extends StateNotifier<List<String>> {
  BlockListController() : super(HostsManager.blockedWebsites);

  void setWebsiteList(List<String> value) {
    state = value;
  }
}
