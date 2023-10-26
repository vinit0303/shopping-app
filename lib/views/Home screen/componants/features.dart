import 'package:get/get.dart';
import 'package:shopping_app/const/consts.dart';
import 'package:shopping_app/views/category_screen/category_details.dart';

Widget featuredButton({String? title, icon}) {
  return Row(
    children: [
      Image.asset(
        icon,
        width: 50,
        fit: BoxFit.fill,
      ),
      10.widthBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  )
      .box
      .white
      .roundedSM
      .width(200)
      .margin(const EdgeInsets.symmetric(horizontal: 4))
      .padding(const EdgeInsets.all(5))
      .outerShadowMd
      .make()
      .onTap(() {
    Get.to(() => CategoryDtails(title: title));
  });
}
