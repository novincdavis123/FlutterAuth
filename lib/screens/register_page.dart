import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/form_textfield.dart';
import '../auth/auth_provider.dart';
import '../utils/validators.dart';
import '../providers/register_form_provider.dart';
import '../providers/password_visibility_provider.dart';
import 'login_page.dart';
import 'package:flutterauth/auth/auth_state.dart';

class RegisterPage extends ConsumerWidget {
  RegisterPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch providers
    final authState = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);
    // Watch form state and notifier
    final formState = ref.watch(registerFormProvider);
    final formNotifier = ref.read(registerFormProvider.notifier);
    // Watch password visibility states and notifiers
    final passwordState = ref.watch(registerPasswordVisibilityProvider);
    final passwordNotifier = ref.read(
      registerPasswordVisibilityProvider.notifier,
    );
    // Confirm password visibility
    final confirmState = ref.watch(registerConfirmPasswordVisibilityProvider);
    final confirmNotifier = ref.read(
      registerConfirmPasswordVisibilityProvider.notifier,
    );

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: _appbar(),
        body: _body(
          context,
          formNotifier,
          passwordState,
          passwordNotifier,
          confirmState,
          confirmNotifier,
          authState,
          formState,
          authNotifier,
        ),
      ),
    );
  }

  // AppBar widget
  AppBar _appbar() => AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Colors.blue.shade100,
    title: const Text('Registration'),
  );

  // Body widget with form
  SingleChildScrollView _body(
    BuildContext context,
    RegisterFormNotifier formNotifier,
    PasswordVisibilityState passwordState,
    PasswordVisibilityNotifier passwordNotifier,
    PasswordVisibilityState confirmState,
    PasswordVisibilityNotifier confirmNotifier,
    AuthState authState,
    RegisterFormState formState,
    AuthNotifier authNotifier,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height - kToolbarHeight - 40,
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Name
                CustomTextfield(
                  controller: _nameController,
                  validator: Validators.name,
                  label: 'Name',
                  onChanged: (value) => formNotifier.updateName(value),
                ),
                const SizedBox(height: 12),

                // Email
                CustomTextfield(
                  controller: _emailController,
                  validator: Validators.email,
                  label: 'Email',
                  onChanged: (value) => formNotifier.updateEmail(value),
                ),
                const SizedBox(height: 12),

                // Password
                CustomTextfield(
                  controller: _passwordController,
                  validator: Validators.password,
                  label: 'Password',
                  obscureText: !passwordState.isVisible,
                  suffixIcon: IconButton(
                    icon: Icon(
                      passwordState.isVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () => passwordNotifier.toggle(),
                  ),
                  onChanged: (value) => formNotifier.updatePassword(value),
                ),
                const SizedBox(height: 12),

                // Confirm Password
                CustomTextfield(
                  controller: _confirmController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Confirm password is required';
                    } else if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  label: 'Confirm Password',
                  obscureText: !confirmState.isVisible,
                  suffixIcon: IconButton(
                    icon: Icon(
                      confirmState.isVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () => confirmNotifier.toggle(),
                  ),
                  onChanged: (value) =>
                      formNotifier.updateConfirmPassword(value),
                ),
                const SizedBox(height: 20),

                // Error
                if (authState.error != null)
                  Text(
                    authState.error!,
                    style: const TextStyle(color: Colors.red),
                  ),
                const SizedBox(height: 8),

                // Register Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade100,
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await authNotifier.register(
                        _emailController.text.trim(),
                        _passwordController.text.trim(),
                      );
                      if (authNotifier.state.error == null && context.mounted) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => LoginPage()),
                        );
                      }
                    }
                  },
                  child: authState.isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Register'),
                ),
                const SizedBox(height: 12),

                // Back to Login
                TextButton(
                  style: ButtonStyle(
                    overlayColor: WidgetStateProperty.all(Colors.transparent),
                    splashFactory: NoSplash.splashFactory,
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => LoginPage()),
                    );
                  },
                  child: const Text('Back to Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
