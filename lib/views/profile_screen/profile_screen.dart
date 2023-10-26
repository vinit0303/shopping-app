import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shopping_app/const/consts.dart';
import 'package:shopping_app/const/lists.dart';
import 'package:shopping_app/controller/auth_controller.dart';
import 'package:shopping_app/controller/profile_controller.dart';
import 'package:shopping_app/services/firestore_services.dart';
import 'package:shopping_app/views/auth%20screen/login_screen.dart';
import 'package:shopping_app/views/chat_screen/messaging_screen.dart';
import 'package:shopping_app/views/orders_screen/orders_screen.dart';
import 'package:shopping_app/views/profile_screen/componants/detail_button.dart';
import 'package:shopping_app/views/profile_screen/editprofile_screen.dart';
import 'package:shopping_app/views/wishlist_screen/wishlist_screeen.dart';
import 'package:shopping_app/widgets/bg_widget.dart';
import 'package:shopping_app/widgets/loading.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return bgWidget(
      child: Scaffold(
        body: StreamBuilder(
            stream: FirestoreServices.getUser(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor)),
                );
              } else {
                var data = snapshot.data!.docs[0];
                return SafeArea(
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Align(
                          alignment: Alignment.topRight,
                          child: Icon(
                            Icons.edit,
                            color: blackcolor,
                          )).onTap(() {
                        controller.nameController.text = data['name'];
                        Get.to(() => EditProfileScreen(
                              data: data,
                            ));
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          data['imageUrl'] == ''
                              ? Image.asset(
                                  imgProfile,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ).box.roundedFull.clip(Clip.antiAlias).make()
                              : Image.network(
                                  data['imageUrl'],
                                  width: 100,
                                  fit: BoxFit.cover,
                                ).box.roundedFull.clip(Clip.antiAlias).make(),
                          10.widthBox,
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "${data['name']}"
                                  .text
                                  .fontFamily(semibold)
                                  .make(),
                              "${data['email']}".text.fontFamily(regular).make()
                            ],
                          )),
                          OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: blackcolor)),
                              onPressed: () async {
                                await Get.put(AuthController())
                                    .signoutMethod(context);
                                Get.offAll(() => LoginScreen());
                              },
                              child: "Logout"
                                  .text
                                  .fontFamily(semibold)
                                  .color(blackcolor)
                                  .make())
                        ],
                      ),
                    ),
                    20.heightBox,
                    FutureBuilder(
                        future: FirestoreServices.getCounts(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: loadingIndicator());
                          } else {
                            var countdata = snapshot.data;
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                detailButton(
                                    count: countdata[0].toString(),
                                    title: "In your cart",
                                    width: context.screenWidth / 3.4),
                                detailButton(
                                    count: countdata[1].toString(),
                                    title: "In your Wishlist",
                                    width: context.screenWidth / 3.4),
                                detailButton(
                                    count: countdata[2].toString(),
                                    title: "your orders",
                                    width: context.screenWidth / 3.4),
                              ],
                            );
                          }
                        }),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     detailButton(
                    //         count: data['cart_count'],
                    //         title: "In your cart",
                    //         width: context.screenWidth / 3.4),
                    //     detailButton(
                    //         count: data['wishList_count'],
                    //         title: "In your Wishlist",
                    //         width: context.screenWidth / 3.4),
                    //     detailButton(
                    //         count: data['order_count'],
                    //         title: "your orders",
                    //         width: context.screenWidth / 3.4),
                    //   ],
                    // ),
                    ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: ((BuildContext context, int index) {
                              return ListTile(
                                onTap: () {
                                  switch (index) {
                                    case 0:
                                      Get.to(() => const OrdersScreen());

                                      break;
                                    case 1:
                                      Get.to(() => const WishlistScreen());
                                      break;
                                    case 2:
                                      Get.to(() => const MessagesScreen());
                                  }
                                },
                                leading: Image.asset(
                                  profileButtonIcon[index],
                                  width: 25,
                                ),
                                title: profileButtonList[index]
                                    .text
                                    .color(darkFontGrey)
                                    .fontFamily(semibold)
                                    .make(),
                              );
                            }),
                            separatorBuilder: (context, index) {
                              return const Divider(
                                color: lightGrey,
                              );
                            },
                            itemCount: profileButtonList.length)
                        .box
                        .white
                        .rounded
                        .shadow3xl
                        .margin(const EdgeInsets.all(14))
                        .padding(const EdgeInsets.symmetric(horizontal: 16))
                        .make()
                        .box
                        .color(redColor)
                        .make(),
                  ],
                ));
              }
            }),
      ),
    );
  }
}
