import 'package:arpan/core/themes/app_pallete.dart';
import 'package:flutter/material.dart';

class CategoryBox extends StatelessWidget {
  final Image image;
  final String nameText;
  final VoidCallback onPressed;
  const CategoryBox(
      {super.key,
      required this.nameText,
      required this.onPressed,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        focusColor: Colors.black,
        hoverColor: Colors.red,
        highlightColor: Colors.purple,
        splashColor: Colors.green,
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: image,
              ),
              const SizedBox(width: 15),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(nameText,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
