import 'package:get/get.dart';

import '../controllers/add_guru_controller.dart';

class AddPelatihBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddGuruController>(
      () => AddGuruController(),
    );
  }
}
