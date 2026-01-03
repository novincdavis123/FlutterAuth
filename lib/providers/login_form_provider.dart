import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginFormState {
  final String identifier; // email or username
  final String password;

  const LoginFormState({this.identifier = '', this.password = ''});

  bool get isValid => identifier.isNotEmpty && password.isNotEmpty;

  LoginFormState copyWith({String? identifier, String? password}) {
    return LoginFormState(
      identifier: identifier ?? this.identifier,
      password: password ?? this.password,
    );
  }
}

// Notifier to update the form state
class LoginFormNotifier extends Notifier<LoginFormState> {
  @override
  LoginFormState build() => const LoginFormState();

  void updateIdentifier(String value) {
    state = state.copyWith(identifier: value);
  }

  void updatePassword(String value) {
    state = state.copyWith(password: value);
  }
}

// Riverpod 3 provider
final loginFormProvider = NotifierProvider<LoginFormNotifier, LoginFormState>(
  LoginFormNotifier.new,
);
