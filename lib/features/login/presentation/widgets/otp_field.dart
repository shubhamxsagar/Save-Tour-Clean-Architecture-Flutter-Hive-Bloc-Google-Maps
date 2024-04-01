import 'package:arpan/common/logger.dart';
import 'package:arpan/features/login/presentation/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:arpan/core/themes/app_pallete.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpField extends StatefulWidget {
  final void Function(List<String> otp) onOtpChanged;
  const OtpField({Key? key, required this.onOtpChanged}) : super(key: key);

  @override
  _OtpFieldState createState() => _OtpFieldState();
}

class _OtpFieldState extends State<OtpField> {
  late List<FocusNode> focusNodes;
  late List<TextEditingController> controllers;

  @override
  void initState() {
    super.initState();
    focusNodes = List.generate(
      4,
      (index) => FocusNode(),
    );
    controllers = List.generate(
      4,
      (index) => TextEditingController(),
    );
    _configureFocusListeners();
  }

  @override
  void dispose() {
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _configureFocusListeners() {
    for (int i = 0; i < focusNodes.length; i++) {
      focusNodes[i].addListener(() {
        if (!focusNodes[i].hasFocus) {
          if (controllers[i].text.isEmpty && i > 0) {
            focusNodes[i - 1].requestFocus();
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (int i = 0; i < 4; i++) ...[
              _textFieldOTP(
                controller: controllers[i],
                focusNode: focusNodes[i],
              ),
              if (i < 3) SizedBox(width: 10),
            ]
          ],
        ),
      ),
    );
  }

  Widget _textFieldOTP({
    required TextEditingController controller,
    required FocusNode focusNode,
  }) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Expanded(
          child: Container(
            height: 85,
            child: AspectRatio(
              aspectRatio: 1.0,
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                onChanged: (value) {
                  if (value.length == 1) {
                    if (controllers.last.text.isNotEmpty) {
                      context.read<LoginBloc>().add(TextFieldFull());
                      // Auto-submit OTP when all fields are filled
                      List<String> otp =
                          controllers.map((e) => e.text).toList();
                      logger.d('OTP: $otp');
                      widget.onOtpChanged(otp);
                    } else {
                      focusNode.nextFocus();
                    }
                  } else if (value.isEmpty) {
                    context.read<LoginBloc>().add(TextFieldEmpty());
                    focusNode.previousFocus();
                  }
                },
                showCursor: false,
                readOnly: false,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                keyboardType: TextInputType.number,
                maxLength: 1,
                decoration: InputDecoration(
                  counter: const Offstage(),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 2, color: Colors.black12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 2, color: AppPallete.gradient2!),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
