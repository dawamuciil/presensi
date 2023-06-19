import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DetailReportController extends GetxController {
  DateTime? start;
  DateTime end = DateTime.now();

  final Map<String, dynamic> presenceData = Get.arguments;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> getAllPresence() async {
    String uid = presenceData["uid"];
    if (start == null) {
      QuerySnapshot<Map<String, dynamic>> query = await firestore
          .collection("pelatih")
          .doc(uid)
          .collection("presence")
          .where("date", isLessThan: end.toIso8601String())
          .orderBy(
            "date",
            descending: true,
          )
          .get();
      return query;
    } else {
      QuerySnapshot<Map<String, dynamic>> query = await firestore
          .collection("pelatih")
          .doc(uid)
          .collection("presence")
          .where("date", isGreaterThan: start!.toIso8601String())
          .where("date",
              isLessThan: end.add(const Duration(days: 1)).toIso8601String())
          .orderBy(
            "date",
            descending: true,
          )
          .get();
      return query;
    }
  }

  void pickDate(DateTime pickStart, DateTime pickEnd) {
    start = pickStart;
    end = pickEnd;

    update();
    Get.back();
  }
}
