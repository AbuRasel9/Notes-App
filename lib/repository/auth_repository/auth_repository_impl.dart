import 'package:bloc_clean_architecture/data/exception/app_exception.dart';
import 'package:bloc_clean_architecture/repository/auth_repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl extends AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
//login
  @override
  Future<void> login(String email, password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      throw BadRequestException();
    }
  }
//registration
  @override
  Future<void> registration(String email, password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      throw BadRequestException();
    }
  }

  Future<void>logout()async{
    try{
      await _auth.signOut();

    }catch(e){
      throw Exception("Logout Failed");
    }


  }

  AppException _handleFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case "invalid-email":
        return InvalidEmailException();
      case "user-disabled":
        return UnauthorizedException();
      case "user-not-found":
        return UserNotFoundException();
      case "email-already-in-use":
        return EmailAlreayUseException();
      case 'invalid-email':
        return EmailAlreayUseException();
      case 'weak-password':
        return WrongPasswordException();

      default:
        return BadRequestException();
    }
  }
}
