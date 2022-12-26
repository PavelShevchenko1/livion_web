import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart';
import 'database.dart';

Future<String> auth(String mail, String pass) async {
  String res = "";
  // await FirebaseAuth.instance
  //     .createUserWithEmailAndPassword(
  //       email: mail,
  //       password: pass,
  //     )
  //     .then((value) => res = "scs")
  //     .catchError((e) {
  //   res = e.code;
  // });

  try {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: mail,
      password: pass,
    );
    res = "scs";
  } on FirebaseAuthException catch (e) {
    res = e.code;
  }
  print(res);
  return res;
}

Future<String> signin(String mail, String pass) async {
  String res = "";
  // await FirebaseAuth.instance
  //     .signInWithEmailAndPassword(email: mail, password: pass)
  //     .then((value) => res = "scs")
  //     .catchError((e) {
  //   res = e.code;
  // });

  // String res = "";
  try {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: mail, password: pass);
    res = "scs";
  } on FirebaseAuthException catch (e) {
    res = e.code;
  }
  return res;
}

Future<String> signout() async {
  String res = "scs";
  await FirebaseAuth.instance.signOut();
  return res;
}

Future<LUser?> getProfileInfo({String? userid}) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    String i = "";
    userid == null ? i = user.uid : i = userid;
    Object udata = await getDB("users/$i");
    if (udata != "err") {
      var f = json.decode(json.encode(udata));

      return LUser(
          name: f["name"],
          sex: f["sex"],
          startw: f["startw"],
          prefw: f["prefw"],
          birth: f["birth"]);
    }
  } else {
    return null;
  }
}

Future<String> resetPasswordByEmail(String mailF) async {
  String status = "";
  await FirebaseAuth.instance
      .sendPasswordResetEmail(email: mailF)
      .then((value) {
    print("y");
    status = "scs";
  }).catchError((e) {
    print(e.code);
    status = e.code;
  });
  return status;
}

Future<String> resetPassword(String oldPass, String newPass) async {
  String email = FirebaseAuth.instance.currentUser!.email!;
  String sts = "";
  String isOldCorrect = await signin(email, oldPass);
  if (isOldCorrect == "scs") {
    try {
      await FirebaseAuth.instance.currentUser!.updatePassword(newPass);
      sts = "sc";
    } on FirebaseAuthException catch (e) {
      sts = e.code;
    }
    if (sts == "sc") {
      try {
        await FirebaseAuth.instance.currentUser!.reauthenticateWithCredential(
            EmailAuthProvider.credential(email: email, password: newPass));
        sts = "scs";
      } on FirebaseAuthException catch (e) {
        sts = e.code;
      }
    }
  } else {
    sts = "err";
  }
  return sts;
}
