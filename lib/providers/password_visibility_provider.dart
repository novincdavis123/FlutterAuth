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

// Riverpod 3 provider
final passwordVisibilityProvider =
    NotifierProvider<PasswordVisibilityNotifier, PasswordVisibilityState>(
      PasswordVisibilityNotifier.new,
    );
