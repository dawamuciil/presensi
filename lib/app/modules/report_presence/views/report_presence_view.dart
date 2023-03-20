import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:presence/app/modules/report_presence/controllers/report_presence_controller.dart';
import 'package:presence/app/modules/report_presence/user_model.dart';
import 'package:presence/app/style/app_color.dart';

class ReportPresenceView extends GetView<ReportPresenceController> {
  const ReportPresenceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Report Presence',
          style: TextStyle(
            color: AppColor.secondary,
            fontSize: 14,
          ),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset('assets/icons/arrow-left.svg'),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: AppColor.secondaryExtraSoft,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: FutureBuilder<List<UserModel>>(
              future: controller.getAllUser(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const Center(child: CircularProgressIndicator());
                  case ConnectionState.active:
                  case ConnectionState.done:
                    int Listalluser = snapshot.data!.length;
                    return ListView.separated(
                      shrinkWrap: true,
                      itemCount: Listalluser,
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                      itemBuilder: (c, index) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              width: 1,
                              color: AppColor.primary,
                            ),
                          ),
                          padding: const EdgeInsets.only(
                              left: 24, top: 20, right: 29, bottom: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Name : ${snapshot.data![index].name}",
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        "Email : ${snapshot.data![index].email}",
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Center(
                                heightFactor: 3,
                                child: Text(
                                  "Job : ${snapshot.data![index].job}",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  default:
                    return const SizedBox();
                }
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColor.primary,
        child: const Icon(Icons.download),
      ),
    );
  }
}
