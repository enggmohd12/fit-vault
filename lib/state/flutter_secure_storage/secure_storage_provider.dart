import 'package:fitvault/services/credential_store.dart';
import 'package:fitvault/services/secure_storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final secureStorageProvider = Provider<SecureStorageService>((ref) {
  return SecureStorageService();
});

final credentialStoreProvider = Provider<CredentialStore>((ref) {
  final secureStorageService = ref.read(secureStorageProvider);
  return CredentialStore(secureStorageService);
});