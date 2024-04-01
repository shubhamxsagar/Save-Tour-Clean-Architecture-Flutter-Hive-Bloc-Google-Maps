import 'package:arpan/core/themes/app_pallete.dart';
import 'package:arpan/features/presentation/drawer/widgets/drawer_list.dart';
import 'package:flutter/material.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppPallete.whiteColor,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 10, 10),
              child: Text(
                'Menu',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
              child: Card(
                color: AppPallete.whiteColor,
                child: Column(
                  children: [
                    DrawerList(
                      iconData1: Icons.person_2_outlined,
                      onPressed: () {},
                      text: "Shubham Sagar",
                    ),
                    DrawerList(
                      iconData1: Icons.star,
                      onPressed: () {},
                      text: "My Ratings",
                    ),
                  ],
                ),
              ),
            ),
            DrawerList(
              iconData1: Icons.credit_card,
              onPressed: () {},
              text: "Payment",
            ),
            DrawerList(
              iconData1: Icons.av_timer_outlined,
              onPressed: () {},
              text: "My Rides",
            ),
            DrawerList(
              iconData1: Icons.safety_check_outlined,
              onPressed: () {},
              text: "Safety",
            ),
            DrawerList(
              iconData1: Icons.notifications_outlined,
              onPressed: () {},
              text: "Notification",
            ),
            DrawerList(
              iconData1: Icons.settings_outlined,
              onPressed: () {},
              text: "Settings",
            ),
          ],
        ),
      ),
    );
  }
}
