import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_app/utils/colors/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

User? userid = FirebaseAuth.instance.currentUser;

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
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("profiles")
                        .where("uid", isEqualTo: userid?.uid)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text("Error");
                      }
                      if (snapshot != null && snapshot.data != null) {
                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: ((context, index) {
                              print(snapshot.data!.docs[index]["name"]);
                              return ListTile(
                                leading: const CircleAvatar(
                                  backgroundImage:
                                      AssetImage("assets/images/profile.jpg"),
                                ),
                                title: Text(
                                  snapshot.data!.docs[index]["name"],
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                subtitle: Text(
                                  "Age: ${snapshot.data!.docs[index]["age"]}",
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              );
                            }));
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
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
