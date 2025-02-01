import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:website_blocker_desktop/features/block_list_controller.dart';
import 'package:website_blocker_desktop/features/edit_list/edit_list_controller.dart';

class EditListScreen extends HookConsumerWidget {
  const EditListScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final blockList = ref.watch(blockListControllerProvider);
    final notifier = ref.read(editListControllerProvider.notifier);

    final textController = useTextEditingController(text: blockList.join('\n'));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit List'),
        titleSpacing: 2,
        actions: [
          FilledButton.icon(
            onPressed: () => notifier.updateList(textController.text),
            label: Text("Save"),
            icon: Icon(Symbols.save, fill: 1),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                  "Enter the websites you want to block. Make sure to enter each website in a new line."),
              const SizedBox(height: 10),
              Expanded(
                child: TextField(
                  maxLines: 20,
                  minLines: 5,
                  controller: textController,
                  decoration: const InputDecoration(
                    hintText: 'facebook.com\ninstagram.com',
                    hintStyle: TextStyle(color: Colors.black26),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
