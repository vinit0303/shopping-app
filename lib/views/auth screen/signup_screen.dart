import 'package:get/get.dart';
import 'package:shopping_app/const/consts.dart';
import 'package:shopping_app/controller/auth_controller.dart';
import 'package:shopping_app/views/Home%20screen/home.dart';
import 'package:shopping_app/widgets/applogo_widget.dart';
import 'package:shopping_app/widgets/bg_widget.dart';
import 'package:shopping_app/widgets/button.dart';
import 'package:shopping_app/widgets/custom_textfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var retypepasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Obx(
            () => Column(
              children: [
                (context.screenHeight * 0.1).heightBox,
                applogoWidget(),
                10.heightBox,
                'Join The $appname'.text.fontFamily(bold).white.size(17).make(),
                10.heightBox,
                Column(
                  children: [
                    customTextField(
                        hint: namehint,
                        title: name,
                        controller: nameController,
                        isPass: false),
                    customTextField(
                        hint: emailHint,
                        title: email,
                        controller: emailController,
                        isPass: false),
                    customTextField(
                        hint: passwordHint,
                        title: password,
                        controller: passwordController,
                        isPass: true),
                    customTextField(
                        hint: passwordHint,
                        title: retypepassword,
                        controller: retypepasswordController,
                        isPass: true),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: forgetpass.text.make(),
                      ),
                    ),
                    2.heightBox,
                    Row(
                      children: [
                        Checkbox(
                            value: isCheck,
                            onChanged: (newValue) {
                              setState(() {
                                isCheck = newValue;
                              });
                            },
                            checkColor: whiteColor),
                        8.widthBox,
                        Expanded(
                          child: RichText(
                              text: const TextSpan(children: [
                            TextSpan(
                                text: "i agree to the",
                                style: TextStyle(
                                    fontFamily: regular, color: fontGrey)),
                            TextSpan(
                                text: termAndCond,
                                style: TextStyle(
                                    fontFamily: regular, color: redColor)),
                            TextSpan(
                                text: "&",
                                style: TextStyle(
                                    fontFamily: regular, color: fontGrey)),
                            TextSpan(
                                text: privacypolicy,
                                style: TextStyle(
                                    fontFamily: regular, color: redColor))
                          ])),
                        )
                      ],
                    ),
                    10.heightBox,
                    controller.isloading.value? const CircularProgressIndicator(
                          valueColor:AlwaysStoppedAnimation(redColor) ,
                        ): ourButton(
                        color: isCheck == true ? redColor : lightgolden,
                        title: signup,
                        textColor: whiteColor,
                        onpress: () async {
                          if (isCheck != false) {
                            controller.isloading(true);
                            try {
                              await controller
                                  .signUpMethod(
                                      context: context,
                                      email: emailController.text,
                                      password: passwordController.text)
                                  .then((value) {
                                return controller.storeUserData(
                              
                                    email: emailController.text,
                                    name: nameController.text,
                                    password: passwordController.text);
                              }).then((value) {
                                VxToast.show(context, msg: loggedin);
                                Get.offAll(() => const Home());
                              });
                            } catch (e) {
                              auth.signOut();
                              // ignore: use_build_context_synchronously
                              VxToast.show(context, msg: e.toString());
                              controller.isloading(false);
                            }
                          }
                        }).box.width(context.screenWidth - 30).make(),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        alreadyHaveAcc.text.color(fontGrey).make(),
                        login.text.color(redColor).make().onTap(() {
                          Get.back();
                        })
                      ],
                    )
                  ],
                )
                    .box
                    .white
                    .rounded
                    .padding(const EdgeInsets.all(16))
                    .width(context.screenWidth - 40)
                    .shadowLg
                    .make()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
