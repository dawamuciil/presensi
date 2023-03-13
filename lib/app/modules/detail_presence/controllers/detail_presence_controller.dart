import 'package:get/get.dart';

class DetailPresenceController extends GetxController {
  final count = 0.obs;

  @override
  void onClose() {}
  void increment() => count.value++;
}
