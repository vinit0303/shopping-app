import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shopping_app/const/consts.dart';
import 'package:shopping_app/services/firestore_services.dart';
import 'package:shopping_app/views/category_screen/item_detail.dart';
import 'package:shopping_app/widgets/loading.dart';

class SearchScreen extends StatelessWidget {
  final String? title;
  const SearchScreen({this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: title!.text.color(fontGrey).make(),
        ),
        body: FutureBuilder(
            future: FirestoreServices.searchProduct(title),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: loadingIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return "No products found".text.makeCentered();
              } else {
                var data = snapshot.data!.docs;
                var filtered = data
                    .where(
                      (element) => element['p_name']
                          .toString()
                          .toLowerCase()
                          .contains(title!.toLowerCase()),
                    )
                    .toList();

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            mainAxisExtent: 300),
                    children: filtered
                        .mapIndexed((currentValue, index) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  filtered[index]['p_imgs'][0],
                                  width: 190,
                                  height: 190,
                                  fit: BoxFit.cover,
                                ),
                                const Spacer(),
                                10.heightBox,
                                "${filtered[index]['p_name']}"
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                                10.heightBox,
                                "${filtered[index]['p_price']}"
                                    .text
                                    .fontFamily(bold)
                                    .size(16)
                                    .color(redColor)
                                    .make()
                              ],
                            )
                                .box
                                .roundedSM
                                .shadowMd
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 8))
                                .padding(const EdgeInsets.all(8))
                                .white
                                .make()
                                .onTap(() {
                              Get.to(() => ItemDetail(
                                    title: "${filtered[index]['p_name']}",
                                    data: filtered[index],
                                  ));
                            }))
                        .toList(),
                  ),
                );
              }
            }));
  }
}
