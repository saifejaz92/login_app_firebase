import 'package:flutter/material.dart';
import 'package:login_app/utils/colors/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
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
                child: const ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/profile.jpg"),
                  ),
                  title: Text(
                    "Saif",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
              ListTile(
                onTap: () {},
                title: const Text("Signout"),
                trailing: const Icon(Icons.logout),
              ),
            ],
          ),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.face_6,
                size: 100,
              ),
              Text(
                "Hey!",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 60),
              ),
              // SizedBox(
              //   height: 10,
              // ),
              Text(
                "Saif",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              Text(
                "Roll No:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
