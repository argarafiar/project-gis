import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:presence/app/routes/app_pages.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() async* {
    String uid = await auth.currentUser!.uid;

    yield* firestore.collection("pegawai").doc(uid).snapshots();
  }

  Future<String> getUserRole() async {
    String uid = auth.currentUser!.uid;

    DocumentSnapshot<Map<String, dynamic>> doc =
        await firestore.collection("pegawai").doc(uid).get();

    print("role: ${doc.data()!["role"]}");

    return doc.data()!["role"];
  }

  void logout() async {
    await auth.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
