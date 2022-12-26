import 'package:firebase_database/firebase_database.dart';

Future<String> updateDB(String path, Map<String, Object?> obj) async {
  String res = "";
  DatabaseReference ref = FirebaseDatabase.instance.ref(path);
  await ref.update(obj).then((_) {
    res = "scs";
  }).catchError((e) {
    res = e.toString();
  });
  return res;
}

Future<String> setDB(String path, Map<String, Object?> obj) async {
  String res = "";
  DatabaseReference ref = FirebaseDatabase.instance.ref(path);
  await ref.set(obj).then((_) {
    res = "scs";
    print(res);
  }).catchError((e) {
    res = e.code;
    print(res);
  });
  return res;
}

Future<Object> getDB(String path) async {
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  final snapshot = await ref.child(path).get(); //with/
  if (snapshot.exists) {
    print(snapshot.value);
    return snapshot.value!;
  } else {
    return "err";
  }
}
