import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tasky/Core/Services/prefrances_maneger.dart';
import 'package:tasky/Core/Theme/themes_controller.dart';
import 'package:tasky/Core/Widgets/custom_svg_picture.dart';
import 'package:tasky/Features/navigaton/main_screen.dart';
import 'package:tasky/Features/profile/user_details_screen.dart';
import 'package:tasky/Features/welcome/welcome_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    _lodeUserName();
    super.initState();
  }

  void _lodeUserName() async {
    setState(() {
      usarName = PrefrancesManeger().getString('username') ?? '';
      motivationQuote =
          PrefrancesManeger().getString('motivationQuote') ??
          "One task at a time. One step closer.";
      userImagePath = PrefrancesManeger().getString('user_image');
      isLoding = false;
    });
  }

  bool isLoding = true;
  String? motivationQuote = '';
  String usarName = '';
  String? userImagePath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My profile'),
        leading: IconButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MainScreen()),
          ),
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: isLoding
          ? Center(child: CircularProgressIndicator(color: Color(0xFFFFFCFC)))
          : Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundImage: userImagePath == null
                              ? AssetImage("assets/images/person.png")
                              : FileImage(File(userImagePath!)),
                          backgroundColor: Colors.transparent,
                        ),
                        GestureDetector(
                          onTap: () async {
                            showImageSorceDialog(context, (XFile file) {
                              _saveImage(file);
                              setState(() {
                                userImagePath = file.path;
                              });
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: ColorScheme.of(context).primaryContainer,
                            ),
                            child: Icon(Icons.photo_camera_outlined),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    Text(usarName, style: TextTheme.of(context).labelSmall),
                    SizedBox(height: 4),
                    Text(
                      motivationQuote ?? "One task at a time. One step closer.",
                      style: TextTheme.of(context).titleSmall,
                    ),
                    SizedBox(height: 20),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Profile Info',
                              style: TextTheme.of(context).labelSmall,
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        ListTile(
                          onTap: () async {
                            final resalt = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserDetailsScreen(
                                  userName: usarName,
                                  motivationQuote: motivationQuote ?? '',
                                ),
                              ),
                            );
                            if (resalt != null && resalt) {
                              _lodeUserName();
                            }
                          },
                          contentPadding: EdgeInsets.zero,
                          title: Text('User Details'),
                          leading: CustomSvgPicture(
                            path: 'assets/images/profile_icon.svg',
                          ),
                          trailing: CustomSvgPicture(
                            path: 'assets/images/arrow_right_icon.svg',
                          ),
                        ),
                        Divider(),
                        ListTile(
                          onTap: () {},
                          contentPadding: EdgeInsets.zero,
                          leading: CustomSvgPicture(
                            path: 'assets/images/moon_icon.svg',
                          ),
                          title: Text('Dark Mode'),
                          trailing: ValueListenableBuilder(
                            valueListenable: ThemesController.themeNotifier,
                            builder: (context, ThemeMode value, Widget? child) {
                              return Switch(
                                value: value == ThemeMode.dark,
                                onChanged: (bool value) async {
                                  ThemesController.toggleTheme();
                                },
                              );
                            },
                          ),
                        ),
                        Divider(),
                        ListTile(
                          onTap: () async {
                            PrefrancesManeger().remove('username');
                            PrefrancesManeger().remove('motivationQuote');
                            PrefrancesManeger().remove('tasks');
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WelcomeScreen(),
                              ),
                              (Route<dynamic> route) => false,
                            );
                          },
                          contentPadding: EdgeInsets.zero,
                          leading: CustomSvgPicture(
                            path: 'assets/images/logout_icon.svg',
                          ),
                          title: Text('Log Out'),
                          trailing: CustomSvgPicture(
                            path: 'assets/images/arrow_right_icon.svg',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  void _saveImage(XFile file) async {
    final appDir = await getApplicationDocumentsDirectory();
    final newFile = await File(file.path).copy('${appDir.path}/${file.name}');
    PrefrancesManeger().setString('user_image', newFile.path);
  }
}

void showImageSorceDialog(BuildContext context, Function(XFile) selectedFile) {
  showDialog(
    context: context,
    builder: (context) {
      return SimpleDialog(
        title: Text(
          'Choose Image Source',
          style: TextTheme.of(context).titleMedium,
        ),
        children: [
          SimpleDialogOption(
            child: Row(
              children: [
                Icon(Icons.camera_alt_outlined),
                SizedBox(width: 10),
                Text('Camera'),
              ],
            ),
            onPressed: () async {
              Navigator.pop(context);
              XFile? image = await ImagePicker().pickImage(
                source: ImageSource.camera,
              );
              if (image != null) {
                selectedFile(image);
              }
            },
          ),
          SimpleDialogOption(
            child: Row(
              children: [
                Icon(Icons.photo_library_outlined),
                SizedBox(width: 10),
                Text('Gallery'),
              ],
            ),
            onPressed: () async {
              Navigator.pop(context);
              XFile? image = await ImagePicker().pickImage(
                source: ImageSource.gallery,
              );
              if (image != null) {
                selectedFile(image);
              }
            },
          ),
        ],
      );
    },
  );
}
