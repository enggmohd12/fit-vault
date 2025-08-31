import 'dart:convert';
import 'dart:math';

import 'package:cryptography/cryptography.dart';

class PasswordHasher {
  static const int iterations = 10000;
  static const int saltLength = 16;
  static const int bits = 256;

  static final Pbkdf2 _algo = Pbkdf2(
    macAlgorithm: Hmac.sha256(),
    iterations: iterations,
    bits: bits,
  );

  static List<int> _random(int n) =>
      List.generate(n, (_) => Random.secure().nextInt(256));
  static String _b64(List<int> b) => base64Encode(b);
  static List<int> _b64d(String s) => base64Decode(s);

  static Future<Map<String, String>> hashPassword(String password) async {
    final salt = _random(saltLength);
    final key = await _algo.deriveKeyFromPassword(
      password: password,
      nonce: salt,
    );
    final bytes = await key.extractBytes();
    return {
      'salt': _b64(salt),
      'hash': _b64(bytes),
      'iter': iterations.toString(),
      'algo': 'pbkdf2-hmac-sha256',
      'dkLen': (bits ~/ 8).toString(),
    };
  }

  static Future<bool> verify({
    required String password,
    required String saltB64,
    required String hashB64,
    int? iterationsOverride,
    int? bitsOverride,
  }) async {
    final salt = _b64d(saltB64);
    final expect = _b64d(hashB64);
    final algo = Pbkdf2(
      macAlgorithm: Hmac.sha256(),
      iterations: iterationsOverride ?? iterations,
      bits: bitsOverride ?? bits,
    );
    final key = await algo.deriveKeyFromPassword(
      password: password,
      nonce: salt,
    );
    final got = await key.extractBytes();
    if (got.length != expect.length) return false;
    var diff = 0;
    for (var i = 0; i < got.length; i++) {
      diff |= got[i] ^ expect[i];
    }
    return diff == 0;
  }
}
