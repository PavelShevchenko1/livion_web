import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

Future<String> uploadAvatar(File file, String uid) async {
  String sts = '';
  final metadata = SettableMetadata(contentType: "image/jpeg");
  final storageRef = FirebaseStorage.instance.ref();
  final uploadTask = storageRef
      .child("images/avatars/${path.basename(file.path)}")
      .putFile(file, metadata);
  uploadTask.onError((error, stackTrace) => throw sts = "err");
  uploadTask.whenComplete(() => sts = "scs");
// // Listen for state changes, errors, and completion of the upload.
//   uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
//     switch (taskSnapshot.state) {
//       case TaskState.running:
//         final progress =
//             100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
//         print("Upload is $progress% complete.");
//         break;
//       case TaskState.paused:
//         print("Upload is paused.");
//         break;
//       case TaskState.canceled:
//         print("Upload was canceled");
//         break;
//       case TaskState.error:
//         // Handle unsuccessful uploads
//         break;
//       case TaskState.success:
//         // Handle successful uploads on complete
//         // ...
//         break;
//     }
//   });
  return sts;
}

Future<String> getAvatar(String userId) async {
  String res = await FirebaseStorage.instance
      .ref("images/avatars/$userId.jpg")
      .getDownloadURL();
  return res;
}
