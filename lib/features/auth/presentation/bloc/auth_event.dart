sealed class AuthEvent {
  const AuthEvent();
}

class SignInWithEmailEvent extends AuthEvent {
  final String email;
  final String password;

  const SignInWithEmailEvent({required this.email, required this.password});
}

class SignUpWithEmailEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;

  const SignUpWithEmailEvent({
    required this.name,
    required this.email,
    required this.password,
  });
}

class SignInWithGoogleEvent extends AuthEvent {
  const SignInWithGoogleEvent();
}

class ResetPasswordEvent extends AuthEvent {
  final String email;

  const ResetPasswordEvent({required this.email});
}

class CheckAuthStatusEvent extends AuthEvent {
  const CheckAuthStatusEvent();
}

class SignOutEvent extends AuthEvent {
  const SignOutEvent();
}
