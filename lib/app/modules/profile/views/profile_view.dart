import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:presence/app/routes/app_pages.dart';
import 'package:presence/app/style/app_color.dart';
import 'package:presence/app/widgets/custom_bottom_navigation_bar.dart';

import '../controllers/profile_controller.dart';
import '../../../controllers/page_index_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final pageC = Get.find<PageIndexController>();
  ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: controller.streamUser(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasData) {
            Map<String, dynamic> user = snap.data!.data()!;
            String defaultImage =
                "https://ui-avatars.com/api/?name=${user['name']}";

            return ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 36),
              children: [
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Image.network(
                            user["profile"] != null
                                ? user["profile"] != ""
                                    ? user["profile"]
                                    : defaultImage
                                : defaultImage,
                            fit: BoxFit.cover),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 16, bottom: 4),
                      child: Text(
                        user["name"],
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Text(
                      user["job"],
                      style: TextStyle(color: AppColor.secondarySoft),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(top: 42),
                  child: Column(
                    children: [
                      MenuTile(
                        title: 'Update Profile',
                        icon: SvgPicture.asset(
                          'assets/icons/profile-1.svg',
                        ),
                        onTap: () =>
                            Get.toNamed(Routes.UPDATE_PROFILE, arguments: user),
                      ),
                      (user["role"] == "admin")
                          ? MenuTile(
                              title: 'Add Guru',
                              icon: SvgPicture.asset(
                                'assets/icons/people.svg',
                              ),
                              onTap: () => Get.toNamed(Routes.ADD_PELATIH),
                            )
                          : const SizedBox(),
                      (user["role"] == "admin")
                          ? MenuTile(
                              title: 'Report Presence',
                              icon: SvgPicture.asset(
                                  'assets/icons/location1.svg'),
                              onTap: () => Get.toNamed(Routes.REPORT_PRESENCE),
                            )
                          : const SizedBox(),
                      MenuTile(
                        title: 'Change Password',
                        icon: SvgPicture.asset(
                          'assets/icons/password.svg',
                        ),
                        onTap: () => Get.toNamed(Routes.UPDATE_PASSWORD),
                      ),
                      MenuTile(
                        isDanger: true,
                        title: 'Sign Out',
                        icon: SvgPicture.asset(
                          'assets/icons/logout.svg',
                        ),
                        onTap: controller.logout,
                      ),
                      Container(
                        height: 1,
                        color: AppColor.primaryExtraSoft,
                      ),
                    ],
                  ),
                )
              ],
            );
          } else {
            return const Center(
              child: Text("Tidak dapat memuat data "),
            );
          }
        },
      ),
    );
  }
}

class MenuTile extends StatelessWidget {
  final String title;
  final Widget icon;
  final void Function() onTap;
  final bool isDanger;
  const MenuTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.isDanger = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: AppColor.secondaryExtraSoft,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              margin: const EdgeInsets.only(right: 24),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColor.primaryExtraSoft,
                borderRadius: BorderRadius.circular(100),
              ),
              child: icon,
            ),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color:
                      (isDanger == false) ? AppColor.secondary : AppColor.error,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 24),
              child: SvgPicture.asset(
                'assets/icons/arrow-right.svg',
                color:
                    (isDanger == false) ? AppColor.secondary : AppColor.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
