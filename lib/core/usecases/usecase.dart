import 'package:barber_flow/core/utils/typedefs.dart';

abstract class UseCase<T, Params> {
  FutureEither<T> call(Params params);
}

class NoParams {
  const NoParams();
}
