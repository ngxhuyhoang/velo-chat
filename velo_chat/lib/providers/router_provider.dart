import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:velo_chat/providers/auth_provider.dart';
import 'package:velo_chat/screens/home.dart';
import 'package:velo_chat/screens/login.dart';
import 'package:velo_chat/screens/splash.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final refresh = ValueNotifier(0);
  ref.listen(authProvider, (_, _) => refresh.value++);
  ref.onDispose(refresh.dispose);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: refresh,
    redirect: (context, state) {
      final auth = ref.read(authProvider);
      final location = state.matchedLocation;

      switch (auth.status) {
        case AuthStatus.unknown:
          return location == '/splash' ? null : '/splash';
        case AuthStatus.loggedOut:
          return location == '/login' ? null : '/login';
        case AuthStatus.loggedIn:
          return (location == '/login' || location == '/splash')
              ? '/home'
              : null;
      }
    },
    routes: [
      GoRoute(path: '/splash', builder: (context, state) => const Splash()),
      GoRoute(path: '/login', builder: (context, state) => const Login()),
      GoRoute(path: '/home', builder: (context, state) => const Home()),
    ],
  );
});
