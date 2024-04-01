import 'package:arpan/core/themes/app_pallete.dart';
import 'package:flutter/material.dart';

class LocationSearchBox extends StatefulWidget {
  const LocationSearchBox({Key? key}) : super(key: key);

  @override
  _LocationSearchBoxState createState() => _LocationSearchBoxState();
}

class _LocationSearchBoxState extends State<LocationSearchBox> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          filled: true,
          fillColor: AppPallete.whiteColor,
          hintText: 'Search Location',
          suffixIcon: const Icon(Icons.search),
          contentPadding: const EdgeInsets.only(left: 20.0, right: 5, bottom: 5),
          focusedBorder: OutlineInputBorder(
              borderSide: const  BorderSide(color: AppPallete.whiteColor),
              borderRadius: BorderRadius.circular(40.0)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppPallete.whiteColor),
              borderRadius: BorderRadius.circular(40.0))),
    );
  }
}
