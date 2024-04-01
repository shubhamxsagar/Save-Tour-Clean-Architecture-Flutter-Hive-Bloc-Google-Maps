import 'package:arpan/common/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

@immutable
class LoginField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final double boxHeight;
  final Function(String)? onChanged;

  bool? field;
  final TextEditingController controller;
  LoginField({
    super.key,
    required this.hintText,
    this.boxHeight = 50.0,
    this.obscureText = false,
    required this.controller,
    field = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    return TextFormField(
      keyboardType: TextInputType.number,
      maxLength: 10,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: SvgPicture.asset(
                  'assets/svg/Flag_of_India.svg',
                  width: 20,
                  height: 20,
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 1.0, 0.0),
                child: Text('+91', style: TextStyle(color: Colors.black87)),
              ),
            ],
          ),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 16.0,
        ),
        contentPadding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(1.0),
          borderSide: const BorderSide(
            color: Colors.black87, // Border color
            width: 0.1, // Border width
          ),
        ),
        // focusedBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(0.0),
        //   borderSide: BorderSide(
        //     color: Colors.black87, // Border color
        //     width: 1.0, // Border width
        //   ),
        // ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Mobile Number is required';
        }
        return null;
      },
      onChanged: onChanged,
      obscureText: obscureText,
    );
  }
}
