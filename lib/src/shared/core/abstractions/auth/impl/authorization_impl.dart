import 'package:flutter_application_1/src/shared/core/abstractions/auth/authorization.dart';
import 'package:flutter_application_1/src/shared/core/abstractions/local_storage/local_storage.dart';
import 'package:flutter_application_1/src/shared/core/abstractions/local_storage/storage_key_type/storage_key_type.dart';
import 'package:flutter_application_1/src/shared/helpers/debug_print/debug_print.dart';

class AuthorizationImpl implements Authorization {
  late LocalStorage _storage;

  static AuthorizationImpl? _instace;

  AuthorizationImpl._singleton(this._storage);

  factory AuthorizationImpl(LocalStorage storage) {
    if (_instace == null) {
      return _instace = AuthorizationImpl._singleton(storage);
    } else {
      return _instace!;
    }
  }

  @override
  Future<bool> logIn({
    required String token,
    String? refreshToken,
  }) async {
    try {
      return await _storage.save(key: StorageKeyType.acessToken, value: token);
    } catch (e) {
      debugPrintHelper(e.toString());
      return Future.value(false);
    }
  }

  @override
  Future<bool> logOut() async {
    try {
      return await _storage.remove(key: StorageKeyType.acessToken);
    } catch (e) {
      debugPrintHelper(e.toString());
      return Future.value(false);
    }
  }
}
