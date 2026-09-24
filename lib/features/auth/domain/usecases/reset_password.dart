import 'package:barber_flow/core/usecases/usecase.dart';
import 'package:barber_flow/core/utils/typedefs.dart';
import 'package:barber_flow/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ResetPassword extends UseCase<void, ResetPasswordParams> {
  final AuthRepository _repository;

  ResetPassword(this._repository);

  @override
  FutureEither<void> call(ResetPasswordParams params) {
    return _repository.resetPassword(params.email);
  }
}

class ResetPasswordParams {
  final String email;

  const ResetPasswordParams({required this.email});
}
