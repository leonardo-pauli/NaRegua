import 'package:barber_flow/core/usecases/usecase.dart';
import 'package:barber_flow/core/utils/typedefs.dart';
import 'package:barber_flow/features/auth/domain/entities/user_entity.dart';
import 'package:barber_flow/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SignInWithGoogle extends UseCase<UserEntity, NoParams> {
  final AuthRepository _repository;

  SignInWithGoogle(this._repository);

  @override
  FutureEither<UserEntity> call(NoParams params) {
    return _repository.signInWithGoogle();
  }
}
