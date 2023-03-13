import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:presence/app/widgets/toast/custom_toast.dart';

class UpdatePasswordController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController currC = TextEditingController();
  TextEditingController newC = TextEditingController();
  TextEditingController confirmC = TextEditingController();

  RxBool oldPassObs = true.obs;
  RxBool newPassObs = true.obs;
  RxBool newPassCObs = true.obs;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> updatePass() async {
    if (currC.text.isNotEmpty &&
        newC.text.isNotEmpty &&
        confirmC.text.isNotEmpty) {
      if (newC.text == confirmC.text) {
        isLoading.value = true;
        try {
          String emailuser = auth.currentUser!.email!;

          await auth.signInWithEmailAndPassword(
              email: emailuser, password: currC.text);

          await auth.currentUser!.updatePassword(newC.text);
          Get.back();

          CustomToast.successToast('Success', 'success change password');
        } on FirebaseAuthException catch (e) {
          if (e.code == "wrong-passwong") {
            CustomToast.errorToast('Error', 'current password wrong');
          } else {
            CustomToast.errorToast(
                'Error', 'cant update password because : ${e.code}');
          }
        } catch (e) {
          CustomToast.errorToast('Error', 'error : ${e.toString()}');
        } finally {
          isLoading.value = false;
        }
      } else {
        CustomToast.errorToast(
            'Error', 'new password and confirm password doesnt match');
      }
    } else {
      CustomToast.errorToast(
          'Error', 'new password and confirm password doesnt match');
    }
  }
}
