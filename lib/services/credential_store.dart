import 'package:fitvault/components/sharedpreference_key.dart';
import 'package:fitvault/services/password_hasher_helper.dart';
import 'package:fitvault/services/secure_storage_service.dart';

class CredentialStore {
  final SecureStorageService _secure;
  CredentialStore(this._secure);

  Future<void> register({
    required String userId,
    required String password,
  }) async {
    if (userId.isEmpty) throw ArgumentError('userId must not be empty.');
    if (password.isEmpty) throw ArgumentError('password must not be empty.');

    final record = await PasswordHasher.hashPassword(password);
    await _secure.write(key: SharedPreferenceKey.kUserId, value: userId);
    await _secure.write(key: SharedPreferenceKey.kSalt, value: record['salt']!);
    await _secure.write(key: SharedPreferenceKey.kHash, value: record['hash']!);
    await _secure.write(key: SharedPreferenceKey.kIter, value: record['iter']!);
    await _secure.write(key: SharedPreferenceKey.kAlg, value: record['algo']!);
    await _secure.write(key: SharedPreferenceKey.kLen, value: record['dkLen']!);
  }

  Future<bool> verify({required String password}) async {
    final salt = await _secure.read(key: SharedPreferenceKey.kSalt);
    final hash = await _secure.read(key: SharedPreferenceKey.kHash);
    if (salt == null || hash == null) return false;

    final iter = int.tryParse(
      await _secure.read(key: SharedPreferenceKey.kIter) ?? '',
    );
    final lenBytes = int.tryParse(
      await _secure.read(key: SharedPreferenceKey.kLen) ?? '',
    );

    final bitsOverride = (lenBytes != null) ? lenBytes * 8 : null;

    return PasswordHasher.verify(
      password: password,
      saltB64: salt,
      hashB64: hash,
      iterationsOverride: iter,
      bitsOverride: bitsOverride,
    );
  }

  Future<void> saveUserId(String userId) =>
      _secure.write(key: SharedPreferenceKey.kUserId, value: userId);

  Future<String?> loadUserId() =>
      _secure.read(key: SharedPreferenceKey.kUserId);

  Future<void> clearAll() async {
    for (final k in [
      SharedPreferenceKey.kUserId,
      SharedPreferenceKey.kSalt,
      SharedPreferenceKey.kHash,
      SharedPreferenceKey.kIter,
      SharedPreferenceKey.kAlg,
      SharedPreferenceKey.kLen,
    ]) {
      await _secure.delete(key: k);
    }
  }
}
