part of 'login_bloc.dart';

@immutable
class LoginState extends Equatable {
  String otp;
  bool isTextFieldFull;
  LoginState({this.isTextFieldFull = false, this.otp = ''});

  @override
  List<Object> get props => [isTextFieldFull];

  LoginState copyWith({bool? isTextFieldFull, String? otp}) {
    return LoginState(
      isTextFieldFull: isTextFieldFull ?? this.isTextFieldFull,
      otp: otp ?? this.otp,
    );
  }
}

class LockInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class HiveBoxOpeningState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoadingState extends LoginState {
  @override
  List<Object> get props => [];
}

class ErrorState extends LoginState {
  final String error;

  ErrorState({this.error = 'Error Occurred!'});
  @override
  List<Object> get props => [error];
}

class LoggedInState extends LoginState {
  final int code;

  LoggedInState({required this.code});
  @override
  List<Object> get props => [code];
}