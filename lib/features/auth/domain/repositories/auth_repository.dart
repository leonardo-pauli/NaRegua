import 'package:barber_flow/core/utils/typedefs.dart';
import 'package:barber_flow/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  FutureEither<UserEntity> signInWithGoogle();
  FutureEither<UserEntity> signInWithEmail(String email, String password);
  FutureEither<UserEntity> signUpWithEmail(String name, String email, String password);
  FutureEither<void> resetPassword(String email);
  FutureEither<UserEntity?> getCurrentUser();
  FutureEither<void> signOut();
}
