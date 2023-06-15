import 'package:get/get.dart';

import '../controllers/detail_report_controller.dart';

class DetailReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailReportController>(
      () => DetailReportController(),
    );
  }
}
