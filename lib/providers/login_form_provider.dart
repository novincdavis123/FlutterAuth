import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginFormState {
  final String email;
  final String password;

  const LoginFormState({this.email = '', this.password = ''});

  bool get isValid => email.isNotEmpty && password.isNotEmpty;

  LoginFormState copyWith({String? email, String? password}) {
    return LoginFormState(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}

// Notifier to update the form state
class LoginFormNotifier extends Notifier<LoginFormState> {
  @override
  LoginFormState build() => const LoginFormState();

  void updateEmail(String value) {
    state = state.copyWith(email: value);
  }

  void updatePassword(String value) {
    state = state.copyWith(password: value);
  }
}

// Riverpod 3 provider
final loginFormProvider = NotifierProvider<LoginFormNotifier, LoginFormState>(
  LoginFormNotifier.new,
);
