import 'package:barber_flow/core/usecases/usecase.dart';
import 'package:barber_flow/core/utils/typedefs.dart';
import 'package:barber_flow/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SignOut extends UseCase<void, NoParams> {
  final AuthRepository _repository;

  SignOut(this._repository);

  @override
  FutureEither<void> call(NoParams params) {
    return _repository.signOut();
  }
}
