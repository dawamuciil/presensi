import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence/app/widgets/dialog/custom_alert_dialog.dart';
import 'package:presence/app/widgets/toast/custom_toast.dart';

class AddGuruController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadingAddPelatih = false.obs;
  TextEditingController nameC = TextEditingController();
  TextEditingController jobC = TextEditingController();
  TextEditingController nipC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController roleC = TextEditingController();
  TextEditingController passAdminC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> prosesAddguru() async {
    if (passAdminC.text.isNotEmpty) {
      isLoadingAddPelatih.value = true;
      try {
        UserCredential pelatihCredential =
            await auth.createUserWithEmailAndPassword(
                email: emailC.text, password: "Guruminu");

        if (pelatihCredential.user != null) {
          String uid = pelatihCredential.user!.uid;

          await firestore.collection("pelatih").doc(uid).set({
            "nip": nipC.text,
            "name": nameC.text,
            "job": jobC.text,
            "email": emailC.text,
            "uid": uid,
            "role": roleC.text,
            "createdAt": DateTime.now().toIso8601String(),
          });

          await pelatihCredential.user!.sendEmailVerification();

          await auth.signOut();

          Get.back();
          Get.back();
          CustomToast.successToast('Success', 'success adding Guru');
        }
        isLoadingAddPelatih.value = false;
      } on FirebaseAuthException catch (e) {
        isLoadingAddPelatih.value = false;
        if (e.code == 'weak-password') {
          CustomToast.errorToast('Error', 'default password too short');
        } else if (e.code == 'email-already-in-use') {
          CustomToast.errorToast('Error', 'Email already exist');
        } else if (e.code == 'wrong-password') {
          CustomToast.errorToast('Error', 'wrong passowrd');
        } else {
          CustomToast.errorToast('Error', 'error : ${e.code}');
        }
      } catch (e) {
        isLoadingAddPelatih.value = false;
        Get.snackbar("terjadi Kesalahan", "Tidak dapat menambahkan pelatih");
      }
    } else {
      isLoading.value = false;
      Get.snackbar("Terjadi Kesalahan", "Password Wajib diisi untuk Validasi");
    }
  }

  Future<void> addguru() async {
    if (nameC.text.isNotEmpty &&
        jobC.text.isNotEmpty &&
        nipC.text.isNotEmpty &&
        roleC.text.isNotEmpty &&
        emailC.text.isNotEmpty) {
      isLoading.value = true;
      CustomAlertDialog.confirmAdmin(
        title: "Validasi Admin",
        message:
            'you need to confirm that you are an administrator by inputting your password',
        onCancel: () {
          isLoading.value = false;
          Get.back();
        },
        onConfirm: () async {
          if (isLoadingAddPelatih.isFalse) {
            await prosesAddguru();
            isLoading.value = false;
          }
        },
        controller: passAdminC,
      );
    } else {
      isLoading.value = false;
      CustomToast.errorToast('Error', 'you need to fill all form');
    }
  }
}
