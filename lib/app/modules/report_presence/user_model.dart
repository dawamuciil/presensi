import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String name;
  final String email;
  final String job;

  const UserModel(
      {this.id, required this.name, required this.email, required this.job});

  toJson() {
    return {"name": name, "email": email, "job": job};
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      id: document.id,
      name: data["name"],
      email: data["email"],
      job: data["job"],
    );
  }
}
