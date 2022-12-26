import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Access extends StatefulWidget {
  Access({Key? key}) : super(key: key);
  static const route = "/access";
  @override
  State<Access> createState() => _AccessState();
}

class _AccessState extends State<Access> {
  String state = "";
  @override
  void initState() {
    if (FirebaseAuth.instance.currentUser == null) {
      setState(() {
        state = "logged OUT";
      });
    } else {
      setState(() {
        state = "logged IN";
      });
    }
    super.initState();
  }

  Future<DataSnapshot> checkAccess() async {
    DatabaseReference roles = FirebaseDatabase.instance.ref("roles/kurator");
    return roles.get();
    // roles.get().then((DataSnapshot s){
    //   if(s.hasChild(FirebaseAuth.instance.currentUser!.uid)){
    //     setState(() {
    //       accs = "Куратор";
    //     });
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(state)),
      body: Container(
        child: FutureBuilder<DataSnapshot>(
          future: checkAccess(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              String accs = "";
              if (snapshot.data!
                  .hasChild(FirebaseAuth.instance.currentUser!.uid)) {
                accs = "Куратор";
              }
              return Container(
                child: Center(child: Text("Вы $accs")),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
