import 'package:flutter_application_1/src/shared/core/environment/env_variables/env.dart';

class Crypto {
  String encryptPassword(String password) {
    try {
      String publicPemFile = Env.get("PUBLIC_KEY");
      //ENCRYPT RSA
      final senhaCrypt = '';
      return senhaCrypt;
    } catch (e) {
      return '';
    }
  }
}
