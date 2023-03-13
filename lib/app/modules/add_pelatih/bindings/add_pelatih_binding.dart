import 'package:get/get.dart';

import '../controllers/add_pelatih_controller.dart';

class AddPelatihBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddPelatihController>(
      () => AddPelatihController(),
    );
  }
}
