import 'package:flutter/material.dart';
import 'package:tasky/Core/Services/prefrances_maneger.dart';
import 'package:tasky/Core/Widgets/custom_svg_picture.dart';
import 'package:tasky/Core/Widgets/custom_text_form_field.dart';
import 'package:tasky/Core/constants/app_sizes.dart';
import 'package:tasky/Core/constants/storage_key.dart';
import 'package:tasky/Features/navigaton/main_screen.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final TextEditingController controller = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: AppSizes.h8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomSvgPicture.whithColorFilter(
                        path: 'assets/images/logo.svg',
                        height: AppSizes.h42,
                        width: AppSizes.w42,
                      ),
                      SizedBox(width: AppSizes.w16),
                      Text('Tasky', style: TextTheme.of(context).displayMedium),
                    ],
                  ),
                  SizedBox(height: AppSizes.h100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome To Tasky ',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      SizedBox(width: AppSizes.w8),
                      CustomSvgPicture.whithColorFilter(
                        path: 'assets/images/waving-hand.svg',
                        height: AppSizes.h28,
                        width: AppSizes.w28,
                      ),
                    ],
                  ),
                  SizedBox(height: AppSizes.h8),
                  Text(
                    'Your productivity journey starts here.',
                    style: Theme.of(
                      context,
                    ).textTheme.displaySmall!.copyWith(fontSize: AppSizes.sp16),
                  ),
                  SizedBox(height: AppSizes.h24),
                  CustomSvgPicture.whithColorFilter(
                    path: 'assets/images/pana.svg',
                    height: AppSizes.h215,
                    width: AppSizes.w215,
                  ),
                  SizedBox(height: AppSizes.h28),
                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: AppSizes.w16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextFormfield(
                          controller: controller,
                          title: "Full Name",
                          hintText: 'e.g. Mohamed Refky',
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your full name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: AppSizes.h24),
                        ElevatedButton(
                          onPressed: () async {
                            if (_key.currentState?.validate() ?? false) {
                              await PrefrancesManeger().setString(
                                StorageKey.username,
                                controller.value.text,
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return MainScreen();
                                  },
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Please Enter Your Full Name"),
                                ),
                              );
                            }
                          },
                          child: Text('Let\'s Get Started'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
