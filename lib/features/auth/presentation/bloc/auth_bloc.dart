import 'package:barber_flow/core/usecases/usecase.dart';
import 'package:barber_flow/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:barber_flow/features/auth/presentation/bloc/auth_event.dart';
import 'package:barber_flow/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInWithGoogle _signInWithGoogle;

  AuthBloc(this._signInWithGoogle) : super(const AuthInitial()) {
    on<SignInWithGoogleEvent>(_onSignInWithGoogle);
    on<SignOutEvent>(_onSignOut);
  }

  Future<void> _onSignInWithGoogle(
    SignInWithGoogleEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await _signInWithGoogle(const NoParams());

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> _onSignOut(
    SignOutEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthInitial());
  }
}
