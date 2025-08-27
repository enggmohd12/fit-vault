Future<(bool, String)> validationRegister({
  required String email,
  required String password,
  required String confirmPassword,
}) async {
  if (email.isEmpty && password.isEmpty && confirmPassword.isEmpty) {
    return (
      false,
      'All fields are required',
    );
  }

  if (email.isEmpty) {
    return (
      false,
      'Login ID cannot be empty',
    );
  }

  if (email.length > 254) {
    return (
      false,
      'Login ID is too long',
    );
  }

  if (password.isEmpty) {
    return (
      false,
      'Password cannot be empty',
    );
  }

  // Password length check
  if (password.length < 8) {
    return (
      false,
      'Password must be at least 8 characters long',
    );
  }

  // Password complexity checks
  final hasUppercase = password.contains(RegExp(r'[A-Z]'));
  final hasLowercase = password.contains(RegExp(r'[a-z]'));
  final hasDigit = password.contains(RegExp(r'\d'));
  final hasSpecialChar = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

  if (!(hasUppercase && hasLowercase && hasDigit && hasSpecialChar)) {
    return (
      false,
      'Password must include uppercase, lowercase, digit, and special character',
    );
  }

  // Confirm password match check
  if (password != confirmPassword) {
    return (
      false,
      'Passwords do not match',
    );
  }

  return (
    true,
    'Validation successful',
  );
}
