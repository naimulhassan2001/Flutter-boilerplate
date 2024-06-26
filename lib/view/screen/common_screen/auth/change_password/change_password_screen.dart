import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/extension/my_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../controllers/common_controller/auth/change_password_controller.dart';
import '../../../../../core/app_routes.dart';
import '../../../../../helpers/reg_exp_helper.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../common_widgets/button/common_button.dart';
import '../../../../common_widgets/text/common_text.dart';
import '../../../../common_widgets/text_field/common_text_field.dart';


class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CommonText(
          text: "Change Password".tr,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: GetBuilder<ChangePasswordController>(
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  70.height,
                  CommonTextField(
                    controller: controller.currentPasswordController,
                    hintText: "Current  Password".tr,
                    validator: OtherHelper.passwordValidator,
                    isPassword: true,
                    prefixIcon: Icon(
                      Icons.lock,
                      size: 20.sp,
                    ),
                  ),
                  16.height,
                  CommonTextField(
                    controller: controller.newPasswordController,
                    hintText: "New Password".tr,
                    validator: OtherHelper.passwordValidator,
                    isPassword: true,
                    prefixIcon: Icon(
                      Icons.lock,
                      size: 20.sp,
                    ),
                  ),
                  16.height,
                  CommonTextField(
                    controller: controller.confirmPasswordController,
                    hintText: "Confirm Password".tr,
                    validator: (value) => OtherHelper.confirmPasswordValidator(
                        value, controller.newPasswordController),
                    isPassword: true,
                    prefixIcon: Icon(
                      Icons.lock,
                      size: 20.sp,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.forgotPassword),
                      child: CommonText(
                        text: "Forgot Password".tr,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp,
                        top: 16.h,
                        bottom: 20.h,
                      ),
                    ),
                  ),
                  CommonButton(
                    titleText: "Confirm".tr,
                    isLoading: controller.isLoading,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        controller.changePasswordRepo();
                      }
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
