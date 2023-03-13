import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence/app/routes/app_pages.dart';
import 'package:presence/app/widgets/dialog/custom_alert_dialog.dart';
import 'package:presence/app/widgets/toast/custom_toast.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool obsecureText = true.obs;
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login() async {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
            email: emailC.text, password: passC.text);

        if (userCredential.user != null) {
          if (userCredential.user!.emailVerified == true) {
            isLoading.value = false;
            if (passC.text == "Ssbpetrokimia") {
              Get.offAllNamed(Routes.NEW_PASSWORD);
            } else {
              Get.offAllNamed(Routes.HOME);
            }
          } else {
            CustomAlertDialog.showPresenceAlert(
              title: "Belum Verivikasi ",
              message: "Kamu belum Melakukan Verivikasi Di email kamu ",
              onCancel: () => Get.back(),
              onConfirm: () async {
                try {
                  await userCredential.user!.sendEmailVerification();
                  Get.back();
                  CustomToast.successToast(
                      "Success", "We've send email verification to your email");
                  isLoading.value = false;
                } catch (e) {
                  CustomToast.errorToast("Error",
                      "Cant send email verification. Error because : ${e.toString()}");
                }
              },
            );
          }
        }
        isLoading.value = false;
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        if (e.code == 'user-not-found') {
          CustomToast.errorToast("Error", "Account not found");
        } else if (e.code == 'wrong-password') {
          CustomToast.errorToast("Error", "Wrong Password");
        }
      } catch (e) {
        CustomToast.errorToast("Error", "Error because : ${e.toString()}");
      }
    } else {
      CustomToast.errorToast(
          "Error", "You need to fill email and password form");
    }
  }
}
