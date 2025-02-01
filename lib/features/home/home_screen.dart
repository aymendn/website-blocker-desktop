import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:website_blocker_desktop/features/block_list_controller.dart';
import 'package:website_blocker_desktop/router/app_router.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final websiteList = ref.watch(blockListControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Current Block List'),
        actions: [
          FilledButton.icon(
            onPressed: () => context.goNamed(AppRoute.editList.name),
            label: Text('Edit List'),
            icon: Icon(Symbols.edit),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Center(
        child: websiteList.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Symbols.link_off, size: 40, color: Colors.black26),
                  SizedBox(height: 12),
                  Text('No websites are currently blocked'),
                ],
              )
            : Scrollbar(
                thumbVisibility: true,
                interactive: false,
                controller: scrollController,
                child: ListView.separated(
                  itemCount: websiteList.length,
                  controller: scrollController,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(color: Colors.black12);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: [
                        Icon(Symbols.link),
                        const SizedBox(width: 10),
                        Expanded(child: Text(websiteList[index])),
                      ],
                    );
                  },
                ),
              ),
      ),
    );
  }
}
