import 'dart:io';

import 'package:get/get.dart';
import 'package:shopping_app/const/consts.dart';
import 'package:shopping_app/controller/profile_controller.dart';
import 'package:shopping_app/widgets/bg_widget.dart';
import 'package:shopping_app/widgets/button.dart';
import 'package:shopping_app/widgets/custom_textfield.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return bgWidget(
        child: Scaffold(
      appBar: AppBar(),
      body: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            data['imageUrl'] == '' && controller.profileImgPath.isEmpty
                ? Image.asset(imgProfile, width: 90, fit: BoxFit.cover)
                    .box
                    .roundedFull
                    .clip(Clip.antiAlias)
                    .make()
                : data['imageUrl'] != '' && controller.profileImgPath.isEmpty
                    ? Image.network(data['imageUrl'],
                            width: 90, fit: BoxFit.cover)
                        .box
                        .roundedFull
                        .clip(Clip.antiAlias)
                        .make()
                    : Image.file(File(controller.profileImgPath.value),
                            width: 90, fit: BoxFit.cover)
                        .box
                        .roundedFull
                        .clip(Clip.antiAlias)
                        .make(),
            10.heightBox,
            ourButton(
                color: redColor,
                textColor: whiteColor,
                title: "change",
                onpress: () {
                  controller.changeImage(context);
                }),
            const Divider(),
            20.heightBox,
            customTextField(
                hint: namehint,
                title: name,
                isPass: false,
                controller: controller.nameController),
            10.heightBox,
            customTextField(
                hint: passwordHint,
                title: oldpass,
                isPass: true,
                controller: controller.oldpasscontroller),
            10.heightBox,
            customTextField(
                hint: passwordHint,
                title: newpass,
                isPass: true,
                controller: controller.newpassController),
            20.heightBox,
            controller.isloading.value
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  )
                : SizedBox(
                    width: context.screenWidth - 50,
                    child: ourButton(
                        color: redColor,
                        textColor: whiteColor,
                        title: 'Save',
                        onpress: () async {
                          controller.isloading(true);
                          if (controller.profileImgPath.value.isNotEmpty) {
                            await controller.uploadProfileImage();
                          } else {
                            controller.profileImageLink = data['imageUrl'];
                          }
                          if (data['password'] ==
                              controller.oldpasscontroller.text) {
                            await controller.changeAuthPassword(
                                email: data['email'],
                                password: controller.oldpasscontroller.text,
                                newpassword: controller.newpassController.text);

                            await controller.updateProfile(
                                imgUrl: controller.profileImageLink,
                                name: controller.nameController.text,
                                password: controller.newpassController.text);

                            VxToast.show(context, msg: "Updated");
                          } else {
                            VxToast.show(context, msg: "wrong old password");
                            controller.isloading(false);
                          }
                        }),
                  )
          ],
        )
            .box
            .shadowLg
            .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
            .padding(const EdgeInsets.all(16))
            .rounded
            .white
            .make(),
      ),
    ));
  }
}
