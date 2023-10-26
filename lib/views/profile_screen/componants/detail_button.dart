import 'package:shopping_app/const/consts.dart';

Widget detailButton({width, String? count, String? title}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.fontFamily(bold).size(18).color(darkFontGrey).make(),
      5.heightBox,
      title!.text.fontFamily(regular).color(darkFontGrey).make(),
    ],
  )
      .box
      .white
      .rounded
      .height(80)
      .shadow3xl
      .padding(const EdgeInsets.all(4))
      .width(width)
      .make();
}
