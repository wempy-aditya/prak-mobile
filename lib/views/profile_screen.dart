import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/user_model.dart';
import '../utils/exports/controllers_exports.dart';
import '../utils/exports/managers_exports.dart';
import '../utils/exports/widgets_exports.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen(
      {super.key,
      required this.user,
      required this.controller,
      required this.isUserBuyer});

  static const String routeName = '/profileScreen';

  final User user;
  final AuthenticateController controller;
  final bool isUserBuyer;

  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        backgroundColor: isDarkMode
            ? DarkColorsManager.scaffoldBgColor
            : ColorsManager.scaffoldBgColor,
        drawer: isUserBuyer
            ? BuyerHomeDrawer(controller: controller)
            : SellerHomeDrawer(controller: controller),
        appBar: AppBar(
          backgroundColor: isDarkMode
              ? DarkColorsManager.scaffoldBgColor
              : ColorsManager.scaffoldBgColor,
          elevation: 0,
          iconTheme: const IconThemeData(color: ColorsManager.secondaryColor),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin:
                const EdgeInsets.symmetric(horizontal: MarginManager.marginL),
            alignment: Alignment.center,
            child: Column(
              children: [
                Stack(
                  children: [
                    Obx(
                      () => CircleAvatar(
                        radius: 64,
                        backgroundImage: profileController.profilePhoto != null
                            ? Image.file(profileController.profilePhoto!).image
                            : user.profilePhoto != ""
                                ? Image.network(user.profilePhoto).image
                                : const NetworkImage(
                                    'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png'),
                        backgroundColor: ColorsManager.backgroundColor,
                      ),
                    ),
                    Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: () => profileController.pickImage(),
                        icon: const Icon(
                          Icons.add_a_photo,
                          color: ColorsManager.secondaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: SizeManager.sizeXL,
                ),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Txt(
                          textAlign: TextAlign.center,
                          text: profileController.userName == ""
                              ? user.name
                              : profileController.userName,
                          color: isDarkMode
                              ? DarkColorsManager.whiteColor
                              : ColorsManager.primaryColor,
                          fontSize: FontSize.textFontSize,
                          fontFamily: FontsManager.fontFamilyPoppins,
                          fontWeight: FontWeightManager.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Txt(
                  text: user.email,
                  color: isDarkMode
                      ? DarkColorsManager.whiteColor
                      : ColorsManager.primaryColor,
                  fontSize: FontSize.subTitleFontSize,
                  fontFamily: FontsManager.fontFamilyPoppins,
                ),
                Obx(
                  () => Txt(
                    text: profileController.userPhone == ""
                        ? user.phone
                        : profileController.userPhone,
                    color: isDarkMode
                        ? DarkColorsManager.whiteColor
                        : ColorsManager.primaryColor,
                    fontSize: FontSize.subTitleFontSize,
                    fontFamily: FontsManager.fontFamilyPoppins,
                  ),
                ),
                Obx(
                  () => Center(
                    child: Txt(
                      text: profileController.userAddress == ""
                          ? user.address
                          : profileController.userAddress,
                      color: isDarkMode
                          ? DarkColorsManager.whiteColor
                          : ColorsManager.primaryColor,
                      fontSize: FontSize.subTitleFontSize,
                      fontFamily: FontsManager.fontFamilyPoppins,
                      useOverflow: true,
                    ),
                  ),
                ),
                const SizedBox(
                  height: SizeManager.sizeXL,
                ),
                const Divider(
                  height: 2,
                  thickness: 2,
                ),
                const SizedBox(
                  height: SizeManager.sizeXL * 3,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        buildUpdatePassDialog(profileController, context);
                      },
                      child: ListTile(
                        leading: const Icon(
                          Icons.lock,
                          color: ColorsManager.secondaryColor,
                        ),
                        title: Txt(
                          text: "Update Password",
                          color: isDarkMode
                              ? DarkColorsManager.whiteColor
                              : ColorsManager.primaryColor,
                          fontSize: FontSize.subTitleFontSize * 1.1,
                          fontWeight: FontWeightManager.medium,
                          fontFamily: FontsManager.fontFamilyPoppins,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: SizeManager.sizeS,
                    ),
                    InkWell(
                      onTap: () async {
                        profileController.nameController.text = user.name;
                        profileController.phoneController.text = user.phone;
                        profileController.addressController.text = user.address;
                        await buildUpdateProfileDialog(
                            profileController, context);
                      },
                      child: ListTile(
                        leading: const Icon(
                          Icons.person,
                          color: ColorsManager.secondaryColor,
                        ),
                        title: Txt(
                          text: "Update Personal Information",
                          color: isDarkMode
                              ? DarkColorsManager.whiteColor
                              : ColorsManager.primaryColor,
                          fontSize: FontSize.subTitleFontSize * 1.1,
                          fontWeight: FontWeightManager.medium,
                          fontFamily: FontsManager.fontFamilyPoppins,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: Get.height * 0.28,
                  margin:
                      const EdgeInsets.only(bottom: PaddingManager.paddingXS),
                  alignment: Alignment.bottomCenter,
                  child: Txt(
                    text: "Powered By INITURE APP",
                    color: isDarkMode
                        ? DarkColorsManager.whiteColor
                        : ColorsManager.primaryColor,
                    fontSize: FontSize.subTitleFontSize * 1.1,
                    fontWeight: FontWeightManager.medium,
                    fontFamily: FontsManager.fontFamilyPoppins,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> buildUpdatePassDialog(
      ProfileController controller, BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Get.defaultDialog(
      title: StringsManager.changePasswordTxt,
      titleStyle: TextStyle(
          color: isDarkMode
              ? DarkColorsManager.whiteColor
              : ColorsManager.primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: FontSize.titleFontSize),
      titlePadding:
          const EdgeInsets.symmetric(vertical: PaddingManager.paddingM),
      radius: 5,
      content: Form(
        key: profileController.editPassFormKey,
        child: Column(
          children: [
            Obx(
              () => CustomTextFormField(
                controller: profileController.oldPasswordController,
                suffixIconData: controller.isObscure1.value
                    ? Icons.visibility_rounded
                    : Icons.visibility_off_rounded,
                onSuffixTap: controller.toggleVisibility1,
                labelText: StringsManager.oldPasswordTxt,
                obscureText: controller.isObscure1.value,
                prefixIconData: Icons.lock,
                textInputAction: TextInputAction.next,
                autofocus: false,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ErrorManager.kPasswordNullError;
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Obx(
              () => CustomTextFormField(
                controller: controller.newPasswordController,
                labelText: StringsManager.newPasswordTxt,
                suffixIconData: controller.isObscure2.value
                    ? Icons.visibility_rounded
                    : Icons.visibility_off_rounded,
                onSuffixTap: controller.toggleVisibility2,
                obscureText: controller.isObscure2.value,
                prefixIconData: Icons.key,
                textInputAction: TextInputAction.next,
                autofocus: false,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ErrorManager.kPasswordNullError;
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Obx(
              () => CustomTextFormField(
                controller: controller.newRePasswordController,
                labelText: StringsManager.newRePasswordTxt,
                suffixIconData: controller.isObscure3.value
                    ? Icons.visibility_rounded
                    : Icons.visibility_off_rounded,
                onSuffixTap: controller.toggleVisibility3,
                obscureText: controller.isObscure3.value,
                prefixIconData: Icons.key,
                textInputAction: TextInputAction.done,
                autofocus: false,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ErrorManager.kPasswordNullError;
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Obx(
              () => CustomButton(
                color: ColorsManager.secondaryColor,
                loadingWidget: controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          backgroundColor: ColorsManager.scaffoldBgColor,
                        ),
                      )
                    : null,
                onPressed: () {
                  controller.changePassword(
                      controller.oldPasswordController.text.trim(),
                      controller.newPasswordController.text.trim(),
                      controller.newRePasswordController.text.trim());
                },
                text: "Change",
                hasInfiniteWidth: true,
                textColor: ColorsManager.whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> buildUpdateProfileDialog(
      ProfileController controller, BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Get.defaultDialog(
      title: "Edit Personal Details",
      titleStyle: TextStyle(
          color: isDarkMode
              ? DarkColorsManager.whiteColor
              : ColorsManager.primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: FontSize.titleFontSize),
      titlePadding:
          const EdgeInsets.symmetric(vertical: PaddingManager.paddingM),
      radius: 5,
      content: Form(
        key: controller.editInfoFormKey,
        child: Column(
          children: [
            CustomTextFormField(
              controller: controller.nameController,
              labelText: StringsManager.nameTxt,
              prefixIconData: Icons.person,
              textInputAction: TextInputAction.next,
              autofocus: false,
              validator: (value) {
                if (value!.isEmpty) {
                  return ErrorManager.kUserNameNullError;
                }
                return null;
              },
            ),
            const SizedBox(height: SizeManager.sizeM),
            CustomTextFormField(
              controller: controller.phoneController,
              labelText: StringsManager.phoneTxt,
              maxLines: 1,
              prefixIconData: Icons.phone,
              textInputAction: TextInputAction.next,
              autofocus: false,
              validator: (value) {
                if (value!.isEmpty) {
                  return ErrorManager.kPhoneNullError;
                }
                return null;
              },
            ),
            const SizedBox(height: SizeManager.sizeM),
            CustomTextFormField(
              controller: controller.addressController,
              labelText: StringsManager.addressTxt,
              prefixIconData: Icons.home,
              textInputAction: TextInputAction.done,
              autofocus: false,
              validator: (value) {
                if (value!.isEmpty) {
                  return ErrorManager.kaddressNullError;
                }
                return null;
              },
            ),
            const SizedBox(height: SizeManager.sizeM),
            CustomButton(
              color: ColorsManager.secondaryColor,
              loadingWidget: controller.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        backgroundColor: ColorsManager.scaffoldBgColor,
                      ),
                    )
                  : null,
              onPressed: () {
                profileController.updateUser(
                  profileController.nameController.text.trim(),
                  profileController.phoneController.text.trim(),
                  profileController.addressController.text.trim(),
                );
              },
              text: "Edit",
              hasInfiniteWidth: true,
              textColor: ColorsManager.whiteColor,
            ),
          ],
        ),
      ),
    );
  }
}
