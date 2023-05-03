// ignore_for_file: prefer_const_constructors, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:ziom/pages/auth/login_page.dart';
import 'package:ziom/pages/home_page.dart';
import 'package:ziom/service/auth_service.dart';
import 'package:ziom/widgets/widgets.dart';

class ProfilePage extends StatefulWidget {
  final String userName;
  final String email;
  const ProfilePage({super.key, required this.userName, required this.email});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: const Text(
          "profile",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 27,
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 50),
          children: [
            Icon(
              Icons.account_circle,
              size: 150,
              color: Colors.grey[800],
            ),
            const SizedBox(height: 20),
            Text(
              widget.userName,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            const Divider(
              height: 2,
            ),
            ListTile(
              onTap: () {
                nextScreen(context, const HomePage());
              },

              // selected: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              leading: const Icon(Icons.group),
              title: const Text(
                "Groups",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            ListTile(
              onTap: () {},
              selected: true,
              selectedColor: Theme.of(context).primaryColor,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              leading: const Icon(Icons.person),
              title: const Text(
                "Profile",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            ListTile(
              onTap: () async {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Log Out"),
                        content: Text("Are you sure you want to log out?"),
                        actions: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 40.0),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.grey[600],
                              ),
                              // onPressed: () {
                              //   print("log out");
                              //   AuthService().signOut().whenComplete(() {
                              //     nextScreenReplace(context, const LoginPage());
                              //   });
                              // },
                              onPressed: () async {
                                await authService.signOut();
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginPage()),
                                    (route) => false);
                              },
                              child: Text("log out",
                                  style: TextStyle(color: Colors.grey[600])),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 40.0),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Theme.of(context).primaryColor,
                              ),
                              onPressed: () {
                                print("stay");
                                Navigator.pop(context);
                              },
                              child: Text(
                                "stay",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                        ],
                      );
                    });
              },
              selectedColor: Theme.of(context).primaryColor,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              leading: const Icon(Icons.logout),
              title: const Text(
                "Log out",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 50,
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.account_circle,
              size: 200,
              color: Colors.grey[600],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Name", style: TextStyle(fontSize: 17)),
                Text(widget.userName, style: TextStyle(fontSize: 17)),
              ],
            ),
            Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Email", style: TextStyle(fontSize: 17)),
                Text(widget.email, style: TextStyle(fontSize: 17)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
