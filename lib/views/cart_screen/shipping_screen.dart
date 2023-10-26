import 'package:get/get.dart';
import 'package:shopping_app/const/consts.dart';
import 'package:shopping_app/controller/cart_controller.dart';
import 'package:shopping_app/views/cart_screen/payment_method.dart';
import 'package:shopping_app/widgets/button.dart';
import 'package:shopping_app/widgets/custom_textfield.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping information"
            .text
            .size(20)
            .fontFamily(bold)
            .color(darkFontGrey)
            .make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
            color: redColor,
            onpress: () {
              if (controller.addressController.text.length > 10 &&
                  controller.phoneController.text.length.isEqual(10)) {
                Get.to(() => const PaymentMethods());
              } else {
                VxToast.show(context, msg: "Please Fill the form");
              }
            },
            textColor: whiteColor,
            title: "Countinue"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            customTextField(
                hint: "Address",
                isPass: false,
                title: "Address",
                controller: controller.addressController),
            customTextField(
                hint: "City",
                isPass: false,
                title: "City",
                controller: controller.cityController),
            customTextField(
                hint: "State",
                isPass: false,
                title: "State",
                controller: controller.stateController),
            customTextField(
                hint: "Postal Code",
                isPass: false,
                title: "Postel Code",
                controller: controller.postelcodeController),
            customTextField(
                hint: "Phone",
                isPass: false,
                title: "Phone",
                controller: controller.phoneController),
          ],
        ),
      ),
    );
  }
}
