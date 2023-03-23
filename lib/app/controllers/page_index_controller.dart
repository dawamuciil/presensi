import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:presence/app/controllers/presence_controller.dart';
import 'package:presence/app/routes/app_pages.dart';

class PageIndexController extends GetxController {
  final presenceController = Get.find<PresenceController>();
  RxInt pageIndex = 0.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamPresence() async* {
    String uid = auth.currentUser!.uid;
    yield* firestore.collection("presence").doc(uid).snapshots();
  }

  void changePage(int index) async {
    pageIndex.value = index;
    switch (index) {
      case 1:
        presenceController.presence();
        break;
      case 2:
        Get.offAllNamed(Routes.PROFILE);
        break;
      default:
        Get.offAllNamed(Routes.HOME);
    }
  }
}
