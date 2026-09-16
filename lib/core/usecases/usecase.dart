import 'package:barber_flow/core/utils/typedefs.dart';

abstract class UseCase<Type, Params> {
  FutureEither<Type> call(Params params);
}

class NoParams {
  const NoParams();
}
