import 'package:barber_flow/core/usecases/usecase.dart';
import 'package:barber_flow/core/utils/typedefs.dart';
import 'package:barber_flow/features/auth/domain/entities/user_entity.dart';
import 'package:barber_flow/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SignUpWithEmail extends UseCase<UserEntity, SignUpWithEmailParams> {
  final AuthRepository _repository;

  SignUpWithEmail(this._repository);

  @override
  FutureEither<UserEntity> call(SignUpWithEmailParams params) {
    return _repository.signUpWithEmail(params.name, params.email, params.password);
  }
}

class SignUpWithEmailParams {
  final String name;
  final String email;
  final String password;

  const SignUpWithEmailParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
