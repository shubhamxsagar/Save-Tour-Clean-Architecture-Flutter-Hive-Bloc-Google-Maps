import 'package:arpan/core/themes/app_pallete.dart';
import 'package:arpan/features/home/widget/category_box.dart';
import 'package:arpan/features/login/presentation/widgets/button_gradient_button.dart';
import 'package:flutter/material.dart';

class SelectionWidget extends StatefulWidget {
  const SelectionWidget({Key? key}) : super(key: key);

  @override
  _SelectionWidgetState createState() => _SelectionWidgetState();
}

class _SelectionWidgetState extends State<SelectionWidget> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.37,
      maxChildSize: 0.9,
      minChildSize: 0.37,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
              color: AppPallete.whiteColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(.8),
                    offset: const Offset(3, 2),
                    blurRadius: 20)
              ]),
          child: Stack(
            children: [
              ListView(
                controller: scrollController,
                children: [
                  CategoryBox(
                    image: Image.asset('assets/images/maid.png'),
                    nameText: 'Maid',
                    onPressed: () {},
                  ),
                  CategoryBox(
                    image: Image.asset('assets/images/contractor.png'),
                    nameText: 'Contractor',
                    onPressed: () {},
                  ),
                  CategoryBox(
                    image: Image.asset('assets/images/plumber.png'),
                    nameText: 'Plumber',
                    onPressed: () {},
                  ),
                  CategoryBox(
                    image: Image.asset('assets/images/driver.png'),
                    nameText: 'Driver',
                    onPressed: () {},
                  ),
                  CategoryBox(
                    image: Image.asset('assets/images/electrician.png'),
                    nameText: 'Electrician',
                    onPressed: () {},
                  ),
                ],
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: AuthGradientButton(
                        buttonText: 'Add Location',
                        onPressed: () {},
                        field: true),
                  ))
            ],
          ),
        );
      },
    );
  }
}
