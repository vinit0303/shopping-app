import 'package:get/get.dart';
import 'package:shopping_app/const/consts.dart';
import 'package:shopping_app/const/lists.dart';
import 'package:shopping_app/controller/auth_controller.dart';
import 'package:shopping_app/views/Home%20screen/home.dart';
import 'package:shopping_app/views/auth%20screen/signup_screen.dart';
import 'package:shopping_app/widgets/applogo_widget.dart';
import 'package:shopping_app/widgets/bg_widget.dart';
import 'package:shopping_app/widgets/button.dart';
import 'package:shopping_app/widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              applogoWidget(),
              10.heightBox,
              'login to $appname'.text.fontFamily(bold).white.size(17).make(),
              10.heightBox,
              Obx(
                () => Column(
                  children: [
                    customTextField(
                        hint: emailHint,
                        title: email,
                        isPass: false,
                        controller: controller.emailController),
                    customTextField(
                        hint: passwordHint,
                        title: password,
                        isPass: true,
                        controller: controller.passwordController),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: forgetpass.text.make(),
                      ),
                    ),
                    5.heightBox,
                    controller.isloading.value
                        ? const CircularProgressIndicator(
                          valueColor:AlwaysStoppedAnimation(redColor) ,
                        )
                        : ourButton(
                            color: redColor,
                            title: login,
                            textColor: whiteColor,
                            onpress: () async {
                              controller.isloading(true);

                              await controller
                                  .loginMethod(context: context)
                                  .then((value) {
                                if (value != null) {
                                  VxToast.show(context, msg: loggedin);
                                  Get.offAll(() => const Home());
                                }else{
                                  controller.isloading(false);
                                }
                              });
                            }).box.width(context.screenWidth - 30).make(),
                    5.heightBox,
                    createNewAccount.text.color(fontGrey).make(),
                    5.heightBox,
                    ourButton(
                        color: lightgolden,
                        title: signup,
                        textColor: redColor,
                        onpress: () {
                          Get.to(() => const SignupScreen());
                        }).box.width(context.screenWidth - 30).make(),
                    10.heightBox,
                    loginwith.text.color(fontGrey).make(),
                    5.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        3,
                        (index) => Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: CircleAvatar(
                            backgroundColor: lightGrey,
                            radius: 25,
                            child: Image.asset(
                              socialIconList[index],
                              width: 34,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
                    .box
                    .white
                    .rounded
                    .padding(const EdgeInsets.all(16))
                    .width(context.screenWidth - 40)
                    .shadowLg
                    .make(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
