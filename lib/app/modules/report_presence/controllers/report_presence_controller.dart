import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:presence/app/modules/report_presence/user_model.dart';
import 'package:presence/app/modules/report_presence/user_repository.dart';

class ReportPresenceController extends GetxController {
  final _userRepo = Get.put(UserRepository());
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<UserModel>> getAllUser() async {
    return await _userRepo.AllUser();
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
