abstract class Authorization {
  Future<bool> logIn({required String token, String? refreshToken});

  Future<bool> logOut();
}
