import 'package:barber_flow/core/usecases/usecase.dart';
import 'package:barber_flow/features/auth/domain/usecases/get_current_user.dart';
import 'package:barber_flow/features/auth/domain/usecases/reset_password.dart';
import 'package:barber_flow/features/auth/domain/usecases/sign_in_with_email.dart';
import 'package:barber_flow/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:barber_flow/features/auth/domain/usecases/sign_out.dart' as uc;
import 'package:barber_flow/features/auth/domain/usecases/sign_up_with_email.dart';
import 'package:barber_flow/features/auth/presentation/bloc/auth_event.dart';
import 'package:barber_flow/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInWithEmail _signInWithEmail;
  final SignUpWithEmail _signUpWithEmail;
  final SignInWithGoogle _signInWithGoogle;
  final ResetPassword _resetPassword;
  final GetCurrentUser _getCurrentUser;
  final uc.SignOut _signOut;

  AuthBloc(
    this._signInWithEmail,
    this._signUpWithEmail,
    this._signInWithGoogle,
    this._resetPassword,
    this._getCurrentUser,
    this._signOut,
  ) : super(const AuthInitial()) {
    on<SignInWithEmailEvent>(_onSignInWithEmail);
    on<SignUpWithEmailEvent>(_onSignUpWithEmail);
    on<SignInWithGoogleEvent>(_onSignInWithGoogle);
    on<ResetPasswordEvent>(_onResetPassword);
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);
    on<SignOutEvent>(_onSignOut);
  }

  Future<void> _onSignInWithEmail(
    SignInWithEmailEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await _signInWithEmail(
      SignInWithEmailParams(email: event.email, password: event.password),
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> _onSignUpWithEmail(
    SignUpWithEmailEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await _signUpWithEmail(
      SignUpWithEmailParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
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

  Future<void> _onResetPassword(
    ResetPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await _resetPassword(
      ResetPasswordParams(email: event.email),
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(const PasswordResetSent()),
    );
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await _getCurrentUser(const NoParams());

    result.fold(
      (failure) => emit(const AuthUnauthenticated()),
      (user) => user != null
          ? emit(AuthSuccess(user))
          : emit(const AuthUnauthenticated()),
    );
  }

  Future<void> _onSignOut(
    SignOutEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await _signOut(const NoParams());

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(const AuthUnauthenticated()),
    );
  }
}
