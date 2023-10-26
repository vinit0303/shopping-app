import 'package:get/get.dart';
import 'package:shopping_app/const/consts.dart';
import 'package:shopping_app/const/lists.dart';
import 'package:shopping_app/controller/product_controller.dart';
import 'package:shopping_app/views/category_screen/category_details.dart';
import 'package:shopping_app/widgets/bg_widget.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return bgWidget(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: categories.text.fontFamily(bold).white.make(),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
            itemCount: 9,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                mainAxisExtent: 200),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Image.asset(
                    categoriesImages[index],
                    height: 120,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                  10.heightBox,
                  categoriesList[index]
                      .text
                      .align(TextAlign.center)
                      .color(darkFontGrey)
                      .make()
                ],
              )
                  .box
                  .white
                  .rounded
                  .outerShadowMd
                  .clip(Clip.antiAlias)
                  .make()
                  .onTap(() {
                controller.getSubCategories(categoriesList[index]);
                Get.to(
                  () => CategoryDtails(
                    title: categoriesList[index],
                  ),
                );
              });
            }),
      ),
    ));
  }
}
