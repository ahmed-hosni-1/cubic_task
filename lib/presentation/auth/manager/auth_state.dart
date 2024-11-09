part of 'auth_cubit.dart';
@immutable
 class AuthState {

  // ApiState googleSignIn;
  // ApiState
}
// sealed class ApiState{
//
// }
final class AuthInitial extends AuthState {}
final class GetBranchesStateLoading extends AuthState {}
final class GetBranchesStateSuccess extends AuthState {
  final List<BranchEntities> branches;
  GetBranchesStateSuccess(this.branches);
}
final class GetBranchesStateFailed extends AuthState {
  final String message;
  GetBranchesStateFailed(this.message);
}

final class SelectBranchState extends AuthState {}
final class RegisterFailedState extends AuthState {
  final String message;
  RegisterFailedState(this.message);
}
final class RegisterSuccessState extends AuthState {}
final class AuthWithGoogleLoadingState extends AuthState {}
final class AuthWithGoogleSuccessState extends AuthState {
  final UserCredential userCredential;
  AuthWithGoogleSuccessState(this.userCredential);
}
final class AuthWithGoogleFailedState extends AuthState {
  final String message;
  AuthWithGoogleFailedState(this.message);
}final class AuthWithAppleLoadingState extends AuthState {}
final class AuthWithAppleSuccessState extends AuthState {
  final UserCredential userCredential;
  AuthWithAppleSuccessState(this.userCredential);
}
final class AuthWithAppleFailedState extends AuthState {
  final String message;
  AuthWithAppleFailedState(this.message);
}

