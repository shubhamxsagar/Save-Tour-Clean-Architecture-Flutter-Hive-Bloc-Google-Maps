import 'package:arpan/common/logger.dart';
import 'package:arpan/core/router/router_constants.dart';
import 'package:arpan/features/login/presentation/bloc/login_bloc.dart';
import 'package:arpan/features/login/presentation/widgets/button_gradient_button.dart';
import 'package:arpan/features/login/presentation/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // final isTextFieldFull = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Enter your number',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Enter your phone number to proceed',
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
                    return LoginField(
                      hintText: '000000000',
                      controller: controller,
                      onChanged: (value) {
                        if (value.length == 10) {
                          context.read<LoginBloc>().add(TextFieldFull());
                          _formKey.currentState!.validate();
                          logger
                              .d('Text field is full ${state.isTextFieldFull}');
                        } else {
                          context.read<LoginBloc>().add(TextFieldEmpty());
                          // state.isTextFieldFull = false;
                        }
                      },
                      field: state.isTextFieldFull,
                    );
                  },
                ),
                const SizedBox(height: 20),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return AuthGradientButton(
                      field: state.isTextFieldFull,
                      buttonText: 'Login',
                      onPressed: () {
                        if (state.isTextFieldFull) {
                          context.read<LoginBloc>().add(TextFieldEmpty());
                          context.goNamed(RouterConstants.otp, pathParameters: {
                            'phoneNo': controller.text,
                          });
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
