import 'package:flutter/material.dart';
import 'package:tasky/Core/Services/prefrances_maneger.dart';
import 'package:tasky/Core/Widgets/custom_text_form_field.dart';
import 'package:tasky/Core/constants/app_sizes.dart';
import 'package:tasky/Core/constants/storage_key.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({
    super.key,
    required this.userName,
    required this.motivationQuote,
  });

  final String userName;
  final String motivationQuote;

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final TextEditingController userNamecontroller = TextEditingController();

  final TextEditingController motivationQuotecontroller =
      TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    userNamecontroller.text = widget.userName;
    motivationQuotecontroller.text = widget.motivationQuote;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "User Details",
          style: TextStyle(color: Color(0xFFFFFCFC), fontSize: AppSizes.sp20),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.w16,
          vertical: AppSizes.h8,
        ),
        child: Form(
          key: _key,
          child: Column(
            children: [
              CustomTextFormfield(
                title: "User Name",
                controller: userNamecontroller,
                hintText: "User Name",
                hintStyle: TextStyle(color: Color(0xFFC6C6C6)),
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return 'Please Enter User Name';
                  }
                  return null;
                },
              ),
              CustomTextFormfield(
                title: "Motivation Quote",
                controller: motivationQuotecontroller,
                hintText: "One task at a time. One step closer.",
                hintStyle: TextStyle(color: Color(0xFFC6C6C6)),
                maxLines: 5,
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return 'Enter Your Motivation Quote';
                  }
                  return null;
                },
              ),
              Spacer(),
              ElevatedButton(
                child: Text(
                  "Save Changes",
                  style: TextStyle(fontSize: AppSizes.sp14),
                ),
                onPressed: () async {
                  if (_key.currentState!.validate()) {
                    await PrefrancesManeger().setString(
                      StorageKey.username,
                      userNamecontroller.text,
                    );
                    await PrefrancesManeger().setString(
                      StorageKey.motivationQuote,
                      motivationQuotecontroller.text,
                    );
                    Navigator.pop(context, true);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
