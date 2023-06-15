import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:presence/app/modules/report_presence/user_model.dart';
import 'package:presence/app/modules/report_presence/user_repository.dart';

class ReportPresenceController extends GetxController {
  final _userRepo = Get.put(UserRepository());
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> getAllUser() async {
    QuerySnapshot<Map<String, dynamic>> query =
        await firestore.collection("pelatih").get();
    return query;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamAll() async* {
    String uid = auth.currentUser!.uid;
    yield* firestore
        .doc(uid)
        .collection("presence")
        .orderBy("date", descending: false)
        .snapshots();
  }
}
