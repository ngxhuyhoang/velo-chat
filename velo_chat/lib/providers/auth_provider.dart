import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velo_chat/providers/token_storage_provider.dart';

enum AuthStatus { unknown, loggedOut, loggedIn }

class AuthState {
  const AuthState({required this.status, this.accessToken});

  final AuthStatus status;
  final String? accessToken;
}

class AuthController extends Notifier<AuthState> {
  @override
  AuthState build() {
    restore(); // chạy nền — đây là "rehydrate" lúc khởi động
    return const AuthState(status: AuthStatus.unknown);
  }

  Future<void> restore() async {
    final token = await ref.read(tokenStorageProvider).readAccessToken();
    state = token == null
        ? const AuthState(status: AuthStatus.loggedOut)
        : AuthState(status: AuthStatus.loggedIn, accessToken: token);
  }

  Future<void> login(String email, String password) async {
    // Giả lập gọi API — thay bằng Firebase/Dio ở bước sau
    await Future.delayed(const Duration(seconds: 2));

    final token = 'fake_access_$email';
    await ref
        .read(tokenStorageProvider)
        .saveTokens(accessToken: token, refreshToken: 'fake_refresh');

    state = AuthState(status: AuthStatus.loggedIn, accessToken: token);
  }

  Future<void> logout() async {
    await ref.read(tokenStorageProvider).clear();
    state = const AuthState(status: AuthStatus.loggedOut);
  }
}

final authProvider = NotifierProvider<AuthController, AuthState>(
  AuthController.new,
);
