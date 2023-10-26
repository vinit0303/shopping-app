import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_app/const/consts.dart';
import 'package:intl/intl.dart' as Intl;

Widget senderBubble(DocumentSnapshot data) {
  var t =
      data['created_on'] == null ? DateTime.now() : data['created_on'].toDate();

  var time = Intl.DateFormat("h:mma").format(t);
  return Directionality(
    textDirection:
        data['uid'] == currentUser!.uid ? TextDirection.rtl : TextDirection.ltr,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: data['uid'] == currentUser!.uid ? redColor : darkFontGrey,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
          ),
          child: "${data['msg']}".text.color(whiteColor).size(16).make(),
        ),
        Align(
            alignment: data['uid'] == currentUser!.uid
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: time.text.color(darkFontGrey.withOpacity(0.5)).make())
      ],
    ),
  );
}
