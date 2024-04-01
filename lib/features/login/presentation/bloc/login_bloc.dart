import 'package:arpan/common/toast.dart';
import 'package:arpan/features/domain/repository/auth_repository.dart';
import 'package:arpan/features/domain/repository/todo_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _lockRepository;
  final TodoRepository _todoRepository;
  LoginBloc(this._lockRepository, this._todoRepository)
      : super(HiveBoxOpeningState()) {
    on<TextFieldFull>(_isTextFieldFull);
    on<TextFieldEmpty>(_isTextFieldEmpty);
    on<OtpValue>(_otpValue);

    on<HiveBoxOpeningEvent>((event, emit) async {
      try {
        await _lockRepository.init();
        await _todoRepository.init();
      } on Exception catch (e) {
        print(e.toString());
      }
      emit(LockInitial());
    });

    on<LoginButtonClickedEvent>((event, emit) async {
      final user = await _lockRepository.authenticate(event.code);
      if (user != null) {
        emit(LoggedInState(code: user));
        emit(LockInitial());
      } else {
        showToast('No records found regarding the user');
        // emit(ErrorState('No records found regarding the user'));
      }
    });

    // at last, the register code bloc
    on<RegisterButtonClickedEvent>((event, emit) async {
      final result = await _lockRepository.registerUser(event.code);
      switch (result) {
        case RegisterResponse.success:
          emit(LoggedInState(code: event.code));
          break;
        case RegisterResponse.failure:
          showToast('An error occurred during Registration, Please try again');
          // emit(const ErrorState(
          //     'An error occurred during Registration, Please try again'));
          break;
        case RegisterResponse.alreadyExists:
          showToast('Looks like, this account already exists, Please try again');
          // emit(const ErrorState(
          //     'Looks like, this account already exists, Please try again'));
          break;
        default:
      }
    });
  }

  void _isTextFieldFull(TextFieldFull event, Emitter<LoginState> emit) {
    emit(state.copyWith(isTextFieldFull: true));
  }

  void _isTextFieldEmpty(TextFieldEmpty event, Emitter<LoginState> emit) {
    emit(state.copyWith(isTextFieldFull: false));
  }

  void _otpValue(OtpValue event, Emitter<LoginState> emit) {
    emit(state.copyWith(otp: event.otp));
  }
}
