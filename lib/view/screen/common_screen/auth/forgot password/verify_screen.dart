import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/utils/app_string.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../controllers/common_controller/auth/forget_password_controller.dart';
import '../../../../../utils/app_colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../component/button/common_button.dart';
import '../../../../component/text/common_text.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    ForgetPasswordController.instance.startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CommonText(
          text: AppString.forgotPassword,
          fontWeight: FontWeight.w700,
          fontSize: 24,
        ),
      ),
      body: GetBuilder<ForgetPasswordController>(
        builder: (controller) => SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Center(
                  child: CommonText(
                    text:
                        "${AppString.codeHasBeenSendTo} ${controller.emailController.text}",
                    fontSize: 18,
                    top: 100,
                    bottom: 60,
                  ),
                ),
                Flexible(
                  flex: 0,
                  child: PinCodeTextField(
                    controller: controller.otpController,
                    validator: (value) {
                      if (value != null && value.length == 6) {
                        return null;
                      } else {
                        return AppString.otpIsInValid;
                      }
                    },
                    autoDisposeControllers: false,
                    cursorColor: AppColors.black,
                    appContext: (context),
                    autoFocus: true,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(8),
                      fieldHeight: 60.h,
                      fieldWidth: 60.w,
                      activeFillColor: AppColors.transparent,
                      selectedFillColor: AppColors.transparent,
                      inactiveFillColor: AppColors.transparent,
                      borderWidth: 0.5.w,
                      selectedColor: AppColors.primaryColor,
                      activeColor: AppColors.primaryColor,
                      inactiveColor: AppColors.black,
                    ),
                    length: 6,
                    keyboardType: TextInputType.number,
                    autovalidateMode: AutovalidateMode.disabled,
                    enableActiveFill: true,
                  ),
                ),
                GestureDetector(
                  onTap: controller.time == '00:00'
                      ? () {
                          controller.startTimer();
                          controller.forgotPasswordRepo();
                        }
                      : () {},
                  child: CommonText(
                    text: controller.time == '00:00'
                        ? AppString.resendCode
                        : "${AppString.resendCodeIn}  ${controller.time} ${AppString.minute}",
                    top: 60,
                    bottom: 100,
                    fontSize: 18,
                  ),
                ),
                CommonButton(
                  titleText: AppString.verify,
                  isLoading: controller.isLoadingVerify,
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      controller.verifyOtpRepo();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
