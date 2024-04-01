import 'package:arpan/core/themes/app_pallete.dart';
import 'package:arpan/features/presentation/drawer/screen/drawer_menu.dart';
import 'package:arpan/features/home/screens/location_screen.dart';
import 'package:arpan/features/home/widget/location_search_box.dart';
import 'package:arpan/features/home/widget/selection_widget.dart';
import 'package:flutter/material.dart';
import 'package:mapmyindia_gl/mapmyindia_gl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void displayDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  void displayEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  late MapmyIndiaMapController mapController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              padding: const EdgeInsets.only(bottom: 300),
              child: const LocationScreen()),
          Positioned(
            top: 80,
            left: 20,
            right: 20,
            child: Row(
              children: [
                Builder(builder: (context) {
                  return InkWell(
                    onTap: () {
                      displayDrawer(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Icon(
                            Icons.menu,
                          )),
                    ),
                  );
                }),
                Expanded(child: LocationSearchBox()),
              ],
            ),
          ),
          SelectionWidget()
        ],
      ),
      drawer: const DrawerMenu(),
    );
  }
}
