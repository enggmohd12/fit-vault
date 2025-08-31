import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static const _iosOptions = IOSOptions(
    accessibility: KeychainAccessibility.first_unlock,
  );

  static const _androidOptions = AndroidOptions(
    encryptedSharedPreferences: true,
  );

  // Create a single, shared instance (do NOT create multiple with different options).
  static final SecureStorageService _instance =
      SecureStorageService._internal();

  factory SecureStorageService() => _instance;

  SecureStorageService._internal()
    : _storage = FlutterSecureStorage(
        iOptions: _iosOptions,
        aOptions: _androidOptions,
      );
  // Singleton instance created above    

  final FlutterSecureStorage _storage;

  FlutterSecureStorage get storage => _storage;
  

  // Basic helpers
  Future<void> write({required String key, required String value}) async {
    await _storage.write(
      key: key,
      value: value,
    );
  }

  Future<String?> read({required String key}) async {
    final data = await _storage.read(
      key: key,
    );
    return data;
  }

  Future<Map<String, String>> readAll() async {
    return await _storage.readAll();
  }

  Future<void> delete({required String key}) => _storage.delete(key: key);

  Future<void> deleteAll() => _storage.deleteAll();
}
