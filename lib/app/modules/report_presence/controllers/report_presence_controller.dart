import 'package:get/get.dart';
import 'package:presence/app/modules/report_presence/user_model.dart';
import 'package:presence/app/modules/report_presence/user_repository.dart';

class ReportPresenceController extends GetxController {
  final _userRepo = Get.put(UserRepository());

  Future<List<UserModel>> getAllUser() async {
    return await _userRepo.AllUser();
  }
}
