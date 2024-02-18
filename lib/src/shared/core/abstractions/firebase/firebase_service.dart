import 'package:flutter_application_1/src/shared/core/abstractions/firebase/model/firebase_response.dart';

abstract class FirebaseService {
  Future<FirebaseResponse> add({required String key, required String value});
}
