import 'package:flutter_application_1/src/shared/core/abstractions/local_storage/local_storage.dart';
import 'package:flutter_application_1/src/shared/core/abstractions/local_storage/storage_key_type/storage_key_type.dart';
import 'package:flutter_application_1/src/shared/helpers/debug_print/debug_print.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageImpl implements LocalStorage {
  late SharedPreferences _storage;
  static LocalStorageImpl? _instace;

  LocalStorageImpl._singleton(this._storage);

  factory LocalStorageImpl(SharedPreferences storage) {
    if (_instace == null) {
      return _instace = LocalStorageImpl._singleton(storage);
    } else {
      return _instace!;
    }
  }

  @override
  bool exist({
    required StorageKeyType key,
  }) {
    debugPrintHelper(
        "Key $key exist: ${_storage.getString(key.name) != null && _storage.getString(key.name)!.isNotEmpty}");

    return _storage.getString(key.name) != null &&
        _storage.getString(key.name)!.isNotEmpty;
  }

  @override
  String read({
    required StorageKeyType key,
  }) {
    return _storage.getString(key.name) ?? '';
  }

  @override
  Future<bool> remove({
    required StorageKeyType key,
  }) async {
    return await _storage.remove(key.name);
  }

  @override
  Future<bool> save({
    required StorageKeyType key,
    required String value,
  }) async {
    return await _storage.setString(key.name, value);
  }
}
