import 'package:shopping_app/const/consts.dart';
import 'package:shopping_app/views/orders_screen/componants/order_place_detail.dart';
import 'package:shopping_app/views/orders_screen/componants/order_status.dart';
import 'package:intl/intl.dart' as intl;

class OrdersDetail extends StatelessWidget {
  final dynamic data;
  const OrdersDetail({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Order Details"
            .text
            .color(darkFontGrey)
            .fontFamily(semibold)
            .make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              ordersStatus(
                  color: redColor,
                  icon: Icons.done,
                  showDone: data['order_placed'],
                  title: "Placed"),
              ordersStatus(
                  color: Vx.blue900,
                  icon: Icons.thumb_up,
                  showDone: data['order_confirmed'],
                  title: "Confirmed"),
              ordersStatus(
                  color: Colors.yellow,
                  icon: Icons.fire_truck,
                  showDone: data['order_on_delivery'],
                  title: "On Delivery"),
              ordersStatus(
                  color: Colors.purple,
                  icon: Icons.done_all_rounded,
                  showDone: data['order_delivered'],
                  title: "Delivered"),
              Divider(),
              10.heightBox,
              Column(
                children: [
                  orderPlacedDetails(
                      d1: data['order_code'],
                      d2: data['shipping_method'],
                      title1: "Order Code",
                      title2: "Shipping method"),
                  orderPlacedDetails(
                      d1: intl.DateFormat()
                          .add_yMd()
                          .format((data['order_date'].toDate())),
                      d2: data['payment_method'],
                      title1: "Order Date",
                      title2: "Payment method"),
                  orderPlacedDetails(
                      d1: "Unpaid",
                      d2: "Order Placed",
                      title1: "Payment Status",
                      title2: "Delivery Status"),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            "Shipping address:"
                                .text
                                .fontFamily(bold)
                                .size(14)
                                .make(),
                            5.heightBox,
                            "${data['order_by_name']}"
                                .text
                                .fontFamily(semibold)
                                .make(),
                            "${data['order_by_email']}"
                                .text
                                .fontFamily(semibold)
                                .make(),
                            "${data['order_by_address']}"
                                .text
                                .fontFamily(semibold)
                                .make(),
                            "${data['order_by_city']}"
                                .text
                                .fontFamily(semibold)
                                .make(),
                            "${data['order_by_state']}"
                                .text
                                .fontFamily(semibold)
                                .make(),
                            "${data['order_by_phone']}"
                                .text
                                .fontFamily(semibold)
                                .make(),
                            "${data['order_by_postelcode']}"
                                .text
                                .fontFamily(semibold)
                                .make()
                          ],
                        ),
                        SizedBox(
                          width: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Total Amount".text.fontFamily(semibold).make(),
                              "${data['total_amount']}"
                                  .text
                                  .color(redColor)
                                  .fontFamily(bold)
                                  .make()
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ).box.shadow4xl.white.roundedSM.make(),
              Divider(),
              10.heightBox,
              "Ordered Product"
                  .text
                  .size(16)
                  .color(darkFontGrey)
                  .fontFamily(semibold)
                  .make(),
              10.heightBox,
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(data['orders'].length, (index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      orderPlacedDetails(
                        d1: "${data['orders'][index]['qty']}x",
                        d2: "Refundable",
                        title1: data['orders'][index]['title'],
                        title2: data['orders'][index]['tprice'],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          width: 30,
                          height: 10,
                          color: Color(data['orders'][index]['color']),
                        ),
                      ),
                      Divider(),
                    ],
                  );
                }).toList(),
              )
                  .box
                  .shadow4xl
                  .white
                  .roundedSM
                  .margin(const EdgeInsets.only(bottom: 4))
                  .make(),
              20.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
