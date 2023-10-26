import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shopping_app/const/consts.dart';
import 'package:shopping_app/controller/product_controller.dart';
import 'package:shopping_app/services/firestore_services.dart';
import 'package:shopping_app/views/category_screen/item_detail.dart';
import 'package:shopping_app/widgets/bg_widget.dart';
import 'package:shopping_app/widgets/loading.dart';

class CategoryDtails extends StatefulWidget {
  const CategoryDtails({super.key, required this.title});
  final String? title;

  @override
  State<CategoryDtails> createState() => _CategoryDtailsState();
}

class _CategoryDtailsState extends State<CategoryDtails> {
  @override
  void initState() {
    super.initState();
    switchCategory(widget.title);
  }

  switchCategory(title) {
    if (controller.subcat.contains(title)) {
      productMethod = FirestoreServices.getSubCategoryProducts(title);
    } else {
      productMethod = FirestoreServices.getProducts(title);
    }
  }

  var controller = Get.find<ProductController>();

  dynamic productMethod;
  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
            appBar: AppBar(
              title: widget.title!.text.fontFamily(bold).white.make(),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                        controller.subcat.length,
                        (index) => "${controller.subcat[index]}"
                                .text
                                .size(12)
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .makeCentered()
                                .box
                                .rounded
                                .white
                                .size(120, 50)
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 4))
                                .make()
                                .onTap(() {
                              switchCategory("${controller.subcat[index]}");
                              setState(() {});
                            })),
                  ).box.padding(const EdgeInsets.all(12)).make(),
                ),
                StreamBuilder(
                    stream: productMethod,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Expanded(
                          child: Center(
                            child: loadingIndicator(),
                          ),
                        );
                      } else if (snapshot.data!.docs.isEmpty) {
                        return Expanded(
                          child: "No product found"
                              .text
                              .white
                              .color(darkFontGrey)
                              .makeCentered(),
                        );
                      } else {
                        var data = snapshot.data!.docs;
                        return Expanded(
                            child: GridView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: data.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisExtent: 250,
                                        mainAxisSpacing: 8,
                                        crossAxisSpacing: 8),
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.network(
                                        data[index]['p_imgs'][0],
                                        width: 200,
                                        height: 150,
                                        fit: BoxFit.cover,
                                      ),
                                      "${data[index]['p_name']}"
                                          .text
                                          .fontFamily(semibold)
                                          .color(darkFontGrey)
                                          .size(17)
                                          .make(),
                                      20.heightBox,
                                      "${data[index]['p_price']}"
                                          .numCurrency
                                          .text
                                          .fontFamily(bold)
                                          .size(16)
                                          .color(redColor)
                                          .make()
                                    ],
                                  )
                                      .box
                                      .roundedSM
                                      .margin(const EdgeInsets.symmetric(
                                          horizontal: 8))
                                      .padding(const EdgeInsets.all(12))
                                      .white
                                      .outerShadowMd
                                      .make()
                                      .onTap(() {
                                    controller.checkIffav(data[index]);
                                    Get.to(
                                      () => ItemDetail(
                                        title: "${data[index]['p_name']}",
                                        data: data[index],
                                      ),
                                    );
                                  });
                                }));
                      }
                    }),
              ],
            )));
  }
}
