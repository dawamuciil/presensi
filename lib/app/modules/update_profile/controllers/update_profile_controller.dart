import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as s;
import 'package:presence/app/widgets/toast/custom_toast.dart';

class UpdateProfileController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController nipC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  s.FirebaseStorage storage = s.FirebaseStorage.instance;

  final ImagePicker picker = ImagePicker();

  XFile? image;

  void pickImage() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    // if (image != null) {
    //   print(image!.name);
    // } else {
    //   print(image);
    // }
    update();
  }

  Future<void> updateProfile(String uid) async {
    if (nipC.text.isNotEmpty &&
        nameC.text.isNotEmpty &&
        emailC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        Map<String, dynamic> data = {
          "name": nameC.text,
        };
        if (image != null) {
          File file = File(image!.path);
          String ext = image!.name.split(".").last;

          await storage.ref('$uid/profile.$ext').putFile(file);
          String urlImage =
              await storage.ref('$uid/profile.$ext').getDownloadURL();

          data.addAll({"profile": urlImage});
        }
        await firestore.collection("pelatih").doc(uid).update(data);
        image = null;
        Get.back();
        CustomToast.successToast('Success', 'Success Update Profile');
      } catch (e) {
        CustomToast.errorToast(
            'Error', 'Cant Update Profile. Err : ${e.toString()}');
      } finally {
        isLoading.value = false;
      }
    } else {
      CustomToast.errorToast('Error', 'You must fill all form');
    }
  }

  void deleteProfile(String uid) async {
    try {
      await firestore.collection("pelatih").doc(uid).update({
        "profile": FieldValue.delete(),
      });

      Get.back();
      Get.snackbar("Berhasil", "Berhasil Delete Profil picture");
    } catch (e) {
      Get.snackbar("Terjadi Kesalahan", "Tidak dapat delete Profil");
    } finally {
      update();
    }
  }
}
