import 'package:flutter/material.dart';

class DrawerList extends StatelessWidget {
  final String text;
  final IconData iconData1;
  final VoidCallback onPressed;
  const DrawerList({
    super.key,
    required this.iconData1,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Row(
          children: [
            Icon(
              iconData1,
            ),
            const SizedBox(width: 10),
            Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(), // Spacer to push the arrow icon to the end
            Icon(
              Icons.arrow_forward_ios_sharp,
              size: 15,
              color: Colors.grey[600],
            ),
          ],
        ),
      ),
    );
  }
}
