import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:presence/app/modules/report_presence/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<UserModel> getUserDetails(String email) async {
    final snapshot =
        await _db.collection("pelatih").where("email", isEqualTo: email).get();
    final userdata = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userdata;
  }

  Future<List<UserModel>> AllUser() async {
    final snapshot = await _db.collection("pelatih").get();
    final userdata =
        snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    return userdata;
  }
}
