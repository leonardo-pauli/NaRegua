import 'package:barber_flow/core/error/exceptions.dart';
import 'package:barber_flow/core/error/failures.dart';
import 'package:barber_flow/core/utils/typedefs.dart';
import 'package:barber_flow/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:barber_flow/features/auth/domain/entities/user_entity.dart';
import 'package:barber_flow/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  FutureEither<UserEntity> signInWithGoogle() async {
    try {
      final user = await _remoteDataSource.signInWithGoogle();
      return Right(user);
    } on ServerException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(AuthFailure('Erro inesperado: $e'));
    }
  }

  @override
  FutureEither<UserEntity> signInWithEmail(String email, String password) async {
    try {
      final user = await _remoteDataSource.signInWithEmail(email, password);
      return Right(user);
    } on ServerException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(AuthFailure('Erro inesperado: $e'));
    }
  }

  @override
  FutureEither<UserEntity> signUpWithEmail(String name, String email, String password) async {
    try {
      final user = await _remoteDataSource.signUpWithEmail(name, email, password);
      return Right(user);
    } on ServerException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(AuthFailure('Erro inesperado: $e'));
    }
  }

  @override
  FutureEither<void> resetPassword(String email) async {
    try {
      await _remoteDataSource.resetPassword(email);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(AuthFailure('Erro inesperado: $e'));
    }
  }

  @override
  FutureEither<UserEntity?> getCurrentUser() async {
    try {
      final user = await _remoteDataSource.getCurrentUser();
      return Right(user);
    } on ServerException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(AuthFailure('Erro inesperado: $e'));
    }
  }

  @override
  FutureEither<void> signOut() async {
    try {
      await _remoteDataSource.signOut();
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Erro ao fazer logout: $e'));
    }
  }
}
