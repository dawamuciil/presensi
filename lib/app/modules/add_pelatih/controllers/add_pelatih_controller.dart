import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPelatihController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadingAddPelatih = false.obs;
  TextEditingController nameC = TextEditingController();
  TextEditingController jobC = TextEditingController();
  TextEditingController nipC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passAdminC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> prosesAddPelatih() async {
    if (passAdminC.text.isNotEmpty) {
      isLoadingAddPelatih.value = true;
      try {
        String emailAdmin = auth.currentUser!.email!;

        UserCredential userCredentialAdmin =
            await auth.signInWithEmailAndPassword(
          email: emailAdmin,
          password: passAdminC.text,
        );

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
            "role": "pelatih",
            "createdAt": DateTime.now().toIso8601String(),
          });

          await pelatihCredential.user!.sendEmailVerification();

          await auth.signOut();

          UserCredential userCredentialAdmin =
              await auth.signInWithEmailAndPassword(
                  email: emailAdmin, password: passAdminC.text);

          Get.back();
          Get.back();
          Get.snackbar("Berhasil", "Berhasil Menambahkan Pelatih");
        }
        isLoadingAddPelatih.value = false;
      } on FirebaseAuthException catch (e) {
        isLoadingAddPelatih.value = false;
        if (e.code == 'weak-password') {
          Get.snackbar("terjadi Kesalahan", "Password Terlalu Singkat ");
        } else if (e.code == 'email-already-in-use') {
          Get.snackbar("terjadi Kesalahan", "Email Sudah Terdaftar");
        } else if (e.code == 'wrong-password') {
          Get.snackbar(
              "terjadi Kesalahan", "Password Admin Salah, Tidak dapat Login");
        } else {
          Get.snackbar("terjadi Kesalahan", "${e.code}");
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

  Future<void> addpelatih() async {
    if (nameC.text.isNotEmpty &&
        jobC.text.isNotEmpty &&
        nipC.text.isNotEmpty &&
        emailC.text.isNotEmpty) {
      isLoading.value = true;
      Get.defaultDialog(
        title: "Validasi Admin",
        content: Column(
          children: [
            const Text("Masukkan Password untuk Validasi "),
            const SizedBox(height: 10),
            TextField(
              controller: passAdminC,
              autocorrect: false,
              obscureText: true,
              decoration: const InputDecoration(
                  labelText: "Password", border: OutlineInputBorder()),
            ),
          ],
        ),
        actions: [
          OutlinedButton(
            onPressed: () {
              isLoading.value = false;
              Get.back();
            },
            child: const Text("Cancel"),
          ),
          Obx(
            () => ElevatedButton(
              onPressed: () async {
                if (isLoadingAddPelatih.isFalse) {
                  await prosesAddPelatih();
                }
                isLoading.value = false;
              },
              child: Text(
                  isLoadingAddPelatih.isFalse ? "ADD PELATIH" : "LOADING..."),
            ),
          ),
        ],
      );
    } else {
      Get.snackbar(
          "terjadi Kesalahan", "NIP , Nama , Job, dan email harus diisi. ");
    }
  }
}
