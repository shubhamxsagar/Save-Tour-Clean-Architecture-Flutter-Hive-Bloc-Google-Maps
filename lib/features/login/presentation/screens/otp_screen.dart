import 'package:arpan/common/logger.dart';
import 'package:arpan/core/router/router_constants.dart';
import 'package:arpan/features/login/presentation/bloc/login_bloc.dart';
import 'package:arpan/features/login/presentation/widgets/button_gradient_button.dart';
import 'package:arpan/features/login/presentation/widgets/otp_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OtpScreen extends StatefulWidget {
  final phoneNo;
  const OtpScreen({super.key, required this.phoneNo});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  List<String> otpDigits = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Verify OTP',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          leading: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  context.read<LoginBloc>().add(TextFieldEmpty());
                  context.replaceNamed(RouterConstants.login);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  size: 35,
                ),
              );
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter verification code',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Sent to ${widget.phoneNo}',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w200,
                  color: Colors.grey[0],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return OtpField(
                    onOtpChanged: (otp) {
                      otpDigits = otp;
                      String otpString = otpDigits.join();
                      state.otp = otpString;
                      logger.d('OTP: ${state.otp}, $otp');
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return AuthGradientButton(
                      field: state.isTextFieldFull,
                      buttonText: 'Next',
                      onPressed: () {
                        if (state.isTextFieldFull) {
                          context.read<LoginBloc>().add(TextFieldEmpty());
                          context.goNamed(RouterConstants.home);
                        }
                      });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
