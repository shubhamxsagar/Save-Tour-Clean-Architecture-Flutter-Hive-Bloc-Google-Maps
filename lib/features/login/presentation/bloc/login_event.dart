part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class TextFieldFull extends LoginEvent {}

class TextFieldEmpty extends LoginEvent {}

class OtpValue extends LoginEvent {
  final String otp;

  OtpValue(this.otp);

  @override
  List<Object> get props => [otp];
}

class HiveBoxOpeningEvent extends LoginEvent {
  @override
  List<Object> get props => [];
}

class LoginButtonClickedEvent extends LoginEvent {
  final int code;

  const LoginButtonClickedEvent(this.code);
  @override
  List<Object> get props => [code];
}

class RegisterButtonClickedEvent extends LoginEvent {
  final int code;

  const RegisterButtonClickedEvent(this.code);
  @override
  List<Object> get props => [code];
}
