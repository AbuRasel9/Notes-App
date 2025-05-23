abstract class AuthRepository{
  Future<void>login(String email,password);
  Future<void>registration(String email,password);
  Future<void>logout();
}