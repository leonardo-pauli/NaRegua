import 'package:fpdart/fpdart.dart';
import 'package:barber_flow/core/error/failures.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureVoid = FutureEither<void>;
