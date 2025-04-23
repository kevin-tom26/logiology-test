import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prodex/features/profile/controller/profile_controller.dart';
import 'package:prodex/utils/constants/colors.dart';
import 'package:prodex/utils/constants/image.dart';

class ProfileCard extends StatelessWidget {
  ProfileCard({super.key});

  final ProfileController controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PColors.secondary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Obx(() {
            return GestureDetector(
              onTap: () {
                showImagePickerDialog(context);
              },
              child: Stack(
                children: [
                  Container(
                    height: context.height * 0.12,
                    width: context.height * 0.12,
                    margin: const EdgeInsets.only(right: 15),
                    decoration: const BoxDecoration(
                        color: PColors.circleColor, shape: BoxShape.circle),
                    child: Center(
                      child: controller.selectedImagePath.value.isEmpty
                          ? Text(
                              controller.userName.value.isNotEmpty
                                  ? controller.userName.value[0].toUpperCase()
                                  : 'X',
                              style: const TextStyle(fontSize: 45),
                            )
                          : ClipOval(
                              child: Image.file(
                                File(controller.selectedImagePath.value),
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 10,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: PColors.white),
                      child: Image.asset(
                        PImages.imageAdd,
                        scale: 1.2,
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
          const Spacer(),
          Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  controller.userName.value,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  '${controller.userName.value}@email.com',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: PColors.darkGrey),
                ),
              ],
            );
          }),
          const Spacer(
            flex: 2,
          )
        ],
      ),
    );
  }

  void showImagePickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Image Source'),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.photo_library, size: 40),
                onPressed: () => controller.pickImage(ImageSource.gallery),
              ),
              IconButton(
                icon: const Icon(Icons.camera_alt, size: 40),
                onPressed: () => controller.pickImage(ImageSource.camera),
              ),
            ],
          ),
        );
      },
    );
  }
}
