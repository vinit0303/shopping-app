import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shopping_app/const/consts.dart';
import 'package:shopping_app/const/lists.dart';
import 'package:shopping_app/controller/home_controller.dart';
import 'package:shopping_app/services/firestore_services.dart';
import 'package:shopping_app/views/Home%20screen/componants/features.dart';
import 'package:shopping_app/views/Home%20screen/search_screen.dart';
import 'package:shopping_app/views/category_screen/item_detail.dart';
import 'package:shopping_app/widgets/large_button.dart';
import 'package:shopping_app/widgets/loading.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    return Container(
        padding: const EdgeInsets.all(5),
        color: lightGrey,
        width: context.screenWidth,
        height: context.screenHeight,
        child: SafeArea(
          child: Column(
            children: [
              TextFormField(
                controller: controller.searchController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: whiteColor,
                  hintText: searchanyything,
                  hintStyle: const TextStyle(color: textfieldGrey),
                  suffixIcon: const Icon(Icons.search).onTap(() {
                    if (controller.searchController.text.isNotEmptyAndNotNull) {
                      Get.to(() => SearchScreen(
                            title: controller.searchController.text,
                          ));
                    }
                  }),
                ),
              )
                  .box
                  .shadow3xl
                  .rounded
                  .height(60)
                  .color(lightGrey)
                  .makeCentered(),
              10.heightBox,
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      VxSwiper.builder(
                          aspectRatio: 16 / 9,
                          autoPlay: true,
                          height: 150,
                          itemCount: slidersList.length,
                          enlargeCenterPage: true,
                          itemBuilder: (context, index) {
                            return Image.asset(
                              slidersList[index],
                              fit: BoxFit.fill,
                            )
                                .box
                                .rounded
                                .clip(Clip.antiAlias)
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 8))
                                .make();
                          }).box.shadow5xl.make(),
                      10.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          2,
                          (index) => largeButton(
                            height: context.screenHeight * 0.12,
                            width: context.screenWidth / 2.5,
                            icon: index == 0 ? icTodaysDeal : icFlashDeal,
                            title: index == 0 ? todayDeaal : flashsale,
                          ),
                        ),
                      ),
                      10.heightBox,
                      VxSwiper.builder(
                          aspectRatio: 16 / 9,
                          autoPlay: true,
                          height: 150,
                          itemCount: secondslidersList.length,
                          enlargeCenterPage: true,
                          itemBuilder: (context, index) {
                            return Image.asset(
                              secondslidersList[index],
                              fit: BoxFit.fill,
                            )
                                .box
                                .rounded
                                .clip(Clip.antiAlias)
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 8))
                                .make();
                          }).box.shadow5xl.make(),
                      10.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          3,
                          (index) => largeButton(
                              height: context.screenHeight * 0.12,
                              width: context.screenWidth / 3.5,
                              icon: index == 0
                                  ? icTopCategories
                                  : index == 1
                                      ? icBrands
                                      : icTopSeller,
                              title: index == 0
                                  ? topcategories
                                  : index == 1
                                      ? brand
                                      : topsaller),
                        ),
                      ),
                      20.heightBox,
                      Align(
                          alignment: Alignment.centerLeft,
                          child: featuredCategories.text
                              .color(darkFontGrey)
                              .size(18)
                              .fontFamily(semibold)
                              .make()),
                      20.heightBox,
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            3,
                            (index) => Column(
                              children: [
                                featuredButton(
                                    icon: featuredList1[index],
                                    title: featturedTitles1[index]),
                                10.heightBox,
                                featuredButton(
                                    icon: featuredList2[index],
                                    title: featturedTitles2[index]),
                              ],
                            ),
                          ).toList(),
                        ),
                      ),
                      20.heightBox,
                      Container(
                        padding: const EdgeInsets.all(12),
                        width: double.infinity,
                        decoration: const BoxDecoration(color: redColor),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            featuredProduct.text
                                .fontFamily(bold)
                                .white
                                .size(19)
                                .make(),
                            10.heightBox,
                            SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: FutureBuilder(
                                    future: FirestoreServices
                                        .getFeaturedProduscts(),
                                    builder: (context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (!snapshot.hasData) {
                                        return Center(
                                            child: loadingIndicator());
                                      } else if (snapshot.data!.docs.isEmpty) {
                                        return "No featured products"
                                            .text
                                            .white
                                            .make();
                                      } else {
                                        var featuredData = snapshot.data!.docs;
                                        return Row(
                                          children: List.generate(
                                              featuredData.length,
                                              (index) => Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Image.network(
                                                        featuredData[index]
                                                            ['p_imgs'][0],
                                                        width: 130,
                                                        height: 130,
                                                        fit: BoxFit.cover,
                                                      ),
                                                      10.heightBox,
                                                      "${featuredData[index]['p_name']}"
                                                          .text
                                                          .fontFamily(semibold)
                                                          .color(darkFontGrey)
                                                          .make(),
                                                      10.heightBox,
                                                      "${featuredData[index]['p_price']}"
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
                                                      .margin(const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 4))
                                                      .padding(
                                                          const EdgeInsets.all(
                                                              8))
                                                      .white
                                                      .make()
                                                      .onTap(() {
                                                    Get.to(() => ItemDetail(
                                                          title:
                                                              "${featuredData[index]['p_name']}",
                                                          data: featuredData[
                                                              index],
                                                        ));
                                                  })),
                                        );
                                      }
                                    }))
                          ],
                        ),
                      ),
                      20.heightBox,
                      VxSwiper.builder(
                          aspectRatio: 16 / 9,
                          autoPlay: true,
                          height: 150,
                          itemCount: secondslidersList.length,
                          enlargeCenterPage: true,
                          itemBuilder: (context, index) {
                            return Image.asset(
                              secondslidersList[index],
                              fit: BoxFit.fill,
                            )
                                .box
                                .rounded
                                .clip(Clip.antiAlias)
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 8))
                                .make();
                          }).box.shadow5xl.make(),
                      20.heightBox,
                      StreamBuilder(
                          stream: FirestoreServices.getallproducts(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return loadingIndicator();
                            } else {
                              var allproductsdata = snapshot.data!.docs;
                              return GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: allproductsdata.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 8,
                                          crossAxisSpacing: 8,
                                          mainAxisExtent: 300),
                                  itemBuilder: (context, index) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.network(
                                          allproductsdata[index]['p_imgs'][0],
                                          width: 190,
                                          height: 190,
                                          fit: BoxFit.cover,
                                        ),
                                        const Spacer(),
                                        10.heightBox,
                                        "${allproductsdata[index]['p_name']}"
                                            .text
                                            .fontFamily(semibold)
                                            .color(darkFontGrey)
                                            .make(),
                                        10.heightBox,
                                        "${allproductsdata[index]['p_price']}"
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
                                        .margin(const EdgeInsets.symmetric(
                                            horizontal: 8))
                                        .padding(const EdgeInsets.all(8))
                                        .white
                                        .make()
                                        .onTap(() {
                                      Get.to(() => ItemDetail(
                                            title:
                                                "${allproductsdata[index]['p_name']}",
                                            data: allproductsdata[index],
                                          ));
                                    });
                                  });
                            }
                          })
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
