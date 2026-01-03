class Validators {
  static String? email(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  static String? emailOrUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email or username is required';
    }
    // Simple email check
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (value.contains('@') && !emailRegex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    // If it doesn't contain @, treat as username (allow letters/numbers, min 3 chars)
    if (!value.contains('@') && value.length < 3) {
      return 'Username must be at least 3 characters';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  static String? name(String? value) {
    if (value == null || value.isEmpty) return 'Name is required';
    return null;
  }
}
