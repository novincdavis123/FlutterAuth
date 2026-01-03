import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterauth/auth/auth_state.dart';
import 'package:flutterauth/providers/password_visibility_provider.dart';
import 'package:flutterauth/screens/home_page.dart';
import 'package:flutterauth/widgets/form_textfield.dart';
import '../auth/auth_provider.dart';
import '../utils/validators.dart';
import 'register_page.dart';
import '../providers/login_form_provider.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch providers
    final authState = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);
    // Watch form state and notifier
    final formState = ref.watch(loginFormProvider);
    final formNotifier = ref.read(loginFormProvider.notifier);
    // Watch password visibility state and notifier
    final passwordVisibility = ref.watch(loginPasswordVisibilityProvider);
    final passwordNotifier = ref.read(loginPasswordVisibilityProvider.notifier);

    // Listen for login success
    ref.listen(authProvider, (previous, next) {
      if (previous?.isLoading == true &&
          next.isLoading == false &&
          next.error == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      }
    });
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: _appBar(),
        body: _body(
          context,
          formNotifier,
          passwordVisibility,
          passwordNotifier,
          authState,
          formState,
          authNotifier,
        ),
      ),
    );
  }

  // AppBar widget
  AppBar _appBar() => AppBar(
    backgroundColor: Colors.blue.shade100,
    title: const Text(
      'Login',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    ),
  );

  // Body widget with form
  SingleChildScrollView _body(
    BuildContext context,
    LoginFormNotifier formNotifier,
    PasswordVisibilityState passwordVisibility,
    PasswordVisibilityNotifier passwordNotifier,
    AuthState authState,
    LoginFormState formState,
    AuthNotifier authNotifier,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: MediaQuery.of(context).size.height - kToolbarHeight - 40,
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Email field
                CustomTextfield(
                  controller: _emailController,
                  validator: Validators.emailOrUsername,
                  label: 'Email/Username',
                  onChanged: (value) => formNotifier.updateIdentifier(value),
                ),
                const SizedBox(height: 12),

                // Password field with visibility toggle
                CustomTextfield(
                  controller: _passwordController,
                  validator: Validators.password,
                  label: 'Password',
                  obscureText: !passwordVisibility.isVisible,
                  suffixIcon: IconButton(
                    icon: Icon(
                      passwordVisibility.isVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () => passwordNotifier.toggle(),
                  ),
                  onChanged: (value) => formNotifier.updatePassword(value),
                ),
                const SizedBox(height: 20),

                // Error message
                if (authState.error != null)
                  Text(
                    authState.error!,
                    style: const TextStyle(color: Colors.red),
                  ),
                const SizedBox(height: 8),

                // Login button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: formState.isValid
                        ? Colors.blue.shade100
                        : Colors.grey,
                  ),
                  onPressed: authState.isLoading || !formState.isValid
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            authNotifier.login(
                              formState.identifier.trim(),
                              _passwordController.text.trim(),
                            );
                          }
                        },
                  child: authState.isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text(
                          'Login',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                ),

                // Links
                TextButton(
                  style: ButtonStyle(
                    overlayColor: WidgetStateProperty.all(Colors.transparent),
                    splashFactory: NoSplash.splashFactory,
                  ),
                  onPressed: () {},
                  child: const Text('Forgot Password?'),
                ),
                TextButton(
                  style: ButtonStyle(
                    overlayColor: WidgetStateProperty.all(Colors.transparent),
                    splashFactory: NoSplash.splashFactory,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => RegisterPage()),
                    );
                  },
                  child: const Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
