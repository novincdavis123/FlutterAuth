import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterauth/auth/auth_state.dart';

// Riverpod 3 Notifier
class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    return const AuthState();
  }

  // Simulated login method
  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    await Future.delayed(const Duration(seconds: 1));

    if (email == 'test@test.com' && password == '123456') {
      state = state.copyWith(isLoading: false);
    } else {
      state = state.copyWith(
        isLoading: false,
        error: 'Invalid email or password',
      );
    }
  }
}

// Riverpod 3 provider
final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);
