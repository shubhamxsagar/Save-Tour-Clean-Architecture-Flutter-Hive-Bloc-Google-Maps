import 'package:arpan/common/logger.dart';
import 'package:arpan/core/themes/app_pallete.dart';
import 'package:flutter/material.dart';

class AuthGradientButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final bool field;
  const AuthGradientButton(
      {super.key,
      required this.buttonText,
      required this.onPressed,
      this.field = false});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    logger.e('field $field');

    return Material(
      child: InkWell(
        onTap: onPressed,
        child: Container(
          width: screenWidth,
          height: 55,
          decoration: BoxDecoration(
            gradient: field
                ? LinearGradient(
                    colors: [
                      AppPallete.gradient1!,
                      AppPallete.gradient2!,
                      AppPallete.gradient2!,
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  )
                : LinearGradient(
                    colors: [
                      Color.fromARGB(255, 244, 244, 244),
                      Color.fromARGB(255, 244, 244, 244),
                      Color.fromARGB(255, 244, 244, 244),
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Center(
              child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: field ? Colors.black : Colors.grey),
          )),
          // child: ElevatedButton(
          //   onPressed: onPressed,
          //   style: ElevatedButton.styleFrom(
          //     fixedSize: const Size(395, 55),
          //     backgroundColor: AppPallete.transparentColor,
          //     shadowColor: AppPallete.transparentColor,
          //   ),
          //   child: Text(
          //     buttonText,
          //     style: const TextStyle(
          //       color: Colors.black,
          //       fontSize: 17,
          //       fontWeight: FontWeight.w600,
          //     ),
          //   ),
          // ),
        ),
      ),
    );
  }
}
