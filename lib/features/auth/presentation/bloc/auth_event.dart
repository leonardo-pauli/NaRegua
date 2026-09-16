sealed class AuthEvent {
  const AuthEvent();
}

class SignInWithGoogleEvent extends AuthEvent {
  const SignInWithGoogleEvent();
}

class SignOutEvent extends AuthEvent {
  const SignOutEvent();
}
