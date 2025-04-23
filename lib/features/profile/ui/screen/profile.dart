import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prodex/features/profile/controller/profile_controller.dart';
import 'package:prodex/features/profile/ui/widget/profile_card.dart';
import 'package:prodex/features/profile/ui/widget/profile_update_card.dart';
import 'package:prodex/utils/constants/colors.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: profileAppbar(context),
      body: Container(
        margin: EdgeInsets.only(
          top: context.height * 0.02,
          left: context.width * 0.03,
          right: context.width * 0.03,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Card
              ProfileCard(),
              SizedBox(height: context.height * 0.04),
              // Update Form Card
              ProfileUpdateCard(),
              SizedBox(height: context.height * 0.06),
              // Logout Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.logout,
                  child: const Text('Logout'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //--Appbar
  AppBar profileAppbar(BuildContext context) {
    return AppBar(
      title: Text(
        'Profile',
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(fontWeight: FontWeight.w600),
      ),
      automaticallyImplyLeading: false,
      actions: [
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              "Back to home",
              style: TextStyle(color: PColors.primary),
            ))
      ],
      centerTitle: false,
      elevation: 4,
      backgroundColor: PColors.white,
      surfaceTintColor: PColors.white,
      shadowColor: Colors.black.withOpacity(0.55),
    );
  }
}
