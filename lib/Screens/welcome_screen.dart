import 'package:flutter/material.dart';
import 'package:tasky/Core/Services/prefrances_maneger.dart';
import 'package:tasky/Core/Widgets/custom_svg_picture.dart';
import 'package:tasky/Core/Widgets/custom_text_form_field.dart';
import 'package:tasky/Screens/main_screen.dart';

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
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomSvgPicture.whithColorFilter(
                        path: 'assets/images/logo.svg',
                        height: 42,
                        width: 42,
                      ),
                      SizedBox(width: 16),
                      Text('Tasky', style: TextTheme.of(context).displayMedium),
                    ],
                  ),
                  SizedBox(height: 118),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome To Tasky ',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      SizedBox(width: 8),
                      CustomSvgPicture.whithColorFilter(
                        path: 'assets/images/waving-hand.svg',
                        height: 28,
                        width: 28,
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Your productivity journey starts here.',
                    style: Theme.of(
                      context,
                    ).textTheme.displaySmall!.copyWith(fontSize: 16),
                  ),
                  SizedBox(height: 24),
                  CustomSvgPicture.whithColorFilter(
                    path: 'assets/images/pana.svg',
                    height: 215,
                    width: 215,
                  ),
                  SizedBox(height: 28),
                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
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
                        SizedBox(height: 24),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            textStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            padding: EdgeInsets.fromLTRB(24, 10, 24, 10),
                            fixedSize: Size(
                              MediaQuery.of(context).size.width,
                              40,
                            ),
                          ),
                          onPressed: () async {
                            if (_key.currentState?.validate() ?? false) {
                              await PrefrancesManeger().setString(
                                'username',
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
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //     SnackBar(
                              //       content: Text('Please enter your full name'),
                              //     ),
                              //   );
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
