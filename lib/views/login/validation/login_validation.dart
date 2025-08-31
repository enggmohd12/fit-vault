Future<(bool, String)> validationLogin({
  required String loginId,
  required String password,
}) async {
  if (loginId.isEmpty && password.isEmpty) {
    return (
      false,
      'Login ID and Password are required',
    );
  }

  if (loginId.isEmpty) {
    return (
      false,
      'Login ID cannot be empty',
    );
  }

  if (loginId.length > 254) {
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

  return (
    true,
    'Validation successful',
  );
}
