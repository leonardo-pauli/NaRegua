import 'package:barber_flow/core/usecases/usecase.dart';
import 'package:barber_flow/core/utils/typedefs.dart';
import 'package:barber_flow/features/auth/domain/entities/user_entity.dart';
import 'package:barber_flow/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SignInWithEmail extends UseCase<UserEntity, SignInWithEmailParams> {
  final AuthRepository _repository;

  SignInWithEmail(this._repository);

  @override
  FutureEither<UserEntity> call(SignInWithEmailParams params) {
    return _repository.signInWithEmail(params.email, params.password);
  }
}

class SignInWithEmailParams {
  final String email;
  final String password;

  const SignInWithEmailParams({required this.email, required this.password});
}
