import 'package:flutter_application_1/src/shared/core/abstractions/local_storage/storage_key_type/storage_key_type.dart';

abstract class LocalStorage {
  Future<bool> save({required StorageKeyType key, required String value});
  Future<bool> remove({required StorageKeyType key});
  bool exist({required StorageKeyType key});
  String read({required StorageKeyType key});
}
