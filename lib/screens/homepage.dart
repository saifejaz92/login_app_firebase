import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_app/utils/colors/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

String? myName;

fetchData() async {
  final firebaseUser = await FirebaseAuth.instance.currentUser;
  if (firebaseUser != null) {
    await FirebaseFirestore.instance
        .collection("profiles")
        .doc(firebaseUser.uid)
        .get()
        .then((ds) {
      myName = ds.get("name");
      print(myName);
    });
  } else {}
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          automaticallyImplyLeading: true,
        ),
        backgroundColor: Colors.white,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: mainColor,
                ),
                child: FutureBuilder(
                    future: fetchData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        print(snapshot.data);
                        return ListTile(
                          leading: const CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/images/profile.jpg"),
                          ),
                          title: Text(
                            myName.toString(),
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
              ),
              ListTile(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context)
                    ..pop()
                    ..pop();
                },
                title: const Text("Signout"),
                trailing: const Icon(Icons.logout),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
