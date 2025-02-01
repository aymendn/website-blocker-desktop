import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PlaygroundScreen extends HookConsumerWidget {
  const PlaygroundScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Playground'),
      ),
      body: Text('Test file compression'),
    );
  }
}
