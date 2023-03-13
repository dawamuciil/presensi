import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:presence/app/style/app_color.dart';

import '../controllers/update_profile_controller.dart';

class UpdateProfileView extends GetView<UpdateProfileController> {
  UpdateProfileView({Key? key}) : super(key: key);
  final Map<String, dynamic> user = Get.arguments;
  @override
  Widget build(BuildContext context) {
    controller.nipC.text = user["nip"];
    controller.nameC.text = user["name"];
    controller.emailC.text = user["email"];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: AppColor.secondary,
            fontSize: 14,
          ),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset('assets/icons/arrow-left.svg'),
        ),
        actions: [
          Obx(
            () => TextButton(
              onPressed: () async {
                if (controller.isLoading.isFalse) {
                  await controller.updateProfile(user["uid"]);
                }
              },
              child: Text(controller.isLoading.isFalse ? "Done" : "Loading..."),
              style: TextButton.styleFrom(primary: AppColor.primary),
            ),
          )
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: AppColor.secondaryExtraSoft,
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(20),
        children: [
          Text(
            "Photo Profile",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GetBuilder<UpdateProfileController>(
                builder: (c) {
                  if (c.image != null) {
                    return ClipOval(
                      child: Container(
                        height: 100,
                        width: 100,
                        child: Image.file(
                          File(c.image!.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  } else {
                    if (user["profile"] != null) {
                      return Column(
                        children: [
                          ClipOval(
                            child: Container(
                              height: 100,
                              width: 100,
                              child: Image.network(
                                user["profile"],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              controller.deleteProfile(user["uid"]);
                            },
                            child: Text("Delete"),
                            style:
                                TextButton.styleFrom(primary: AppColor.error),
                          )
                        ],
                      );
                    } else {
                      return Text("no image choosen");
                    }
                  }
                },
              ),
              TextButton(
                  onPressed: () {
                    controller.pickImage();
                  },
                  child: Text("choose file"),
                  style: TextButton.styleFrom(primary: AppColor.buttontext))
            ],
          ),
          TextField(
            readOnly: true,
            autocorrect: false,
            controller: controller.nipC,
            decoration: const InputDecoration(
                labelText: "NIP", border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            readOnly: true,
            autocorrect: false,
            controller: controller.emailC,
            decoration: const InputDecoration(
                labelText: "Email", border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            autocorrect: false,
            controller: controller.nameC,
            decoration: const InputDecoration(
                labelText: "Name", border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 25,
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
