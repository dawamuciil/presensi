import 'package:get/get.dart';
import 'package:presence/app/modules/report_presence/controllers/report_presence_controller.dart';

class ReportpresenceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportPresenceController>(
      () => ReportPresenceController(),
    );
  }
}
