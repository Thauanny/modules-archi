import 'package:flutter_application_1/src/shared/core/abstractions/firebase/firestore/model/firebase_response.dart';

abstract class FirebaseFireStoreFacade {
  Future<FirebaseFireStoreResponse> add({
    required String key,
    required String value,
  });
  Future<FirebaseFireStoreResponse> addMap({
    required Map<String, dynamic> map,
  });
  Future<void> readAll();
  Future<void> readById({
    required String idDocument,
  });
  Future<void> readWhere({
    required String key,
    required String value,
  });

  Future<void> update({
    required String idDocument,
    bool merge = false,
    required Map<String, dynamic> data,
  });
}
