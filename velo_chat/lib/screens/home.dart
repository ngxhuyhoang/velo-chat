import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velo_chat/providers/auth_provider.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Center(
        child: FilledButton(
          onPressed: () => ref.read(authProvider.notifier).logout(),
          child: Text("Home"),
        ),
      ),
    );
  }
}
