import 'package:flutter_riverpod/flutter_riverpod.dart';

// State for visibility
class PasswordVisibilityState {
  final bool isVisible;
  const PasswordVisibilityState({this.isVisible = false});
}

// Notifier to toggle visibility
class PasswordVisibilityNotifier extends Notifier<PasswordVisibilityState> {
  @override
  PasswordVisibilityState build() => const PasswordVisibilityState();

  void toggle() {
    state = PasswordVisibilityState(isVisible: !state.isVisible);
  }
}

// Login password visibility (used in LoginPage)
final loginPasswordVisibilityProvider =
    NotifierProvider<PasswordVisibilityNotifier, PasswordVisibilityState>(
      PasswordVisibilityNotifier.new,
    );

// Registration password visibility
final registerPasswordVisibilityProvider =
    NotifierProvider<PasswordVisibilityNotifier, PasswordVisibilityState>(
      PasswordVisibilityNotifier.new,
    );

// Registration confirm password visibility
final registerConfirmPasswordVisibilityProvider =
    NotifierProvider<PasswordVisibilityNotifier, PasswordVisibilityState>(
      PasswordVisibilityNotifier.new,
    );
