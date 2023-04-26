import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenify_new/providers/user_provider.dart';
import 'package:greenify_new/utilities/authcontroller.dart';
import 'package:greenify_new/utilities/snackbar.dart';
import 'package:greenify_new/utilities/user.dart' as model;
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  String uid;
  ProfilePage({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var userData = {};
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();
      userData = userSnap.data()!;
      setState(() {});
    } catch (e) {
      showSnackBar("Error", e.toString(), context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    model.User user = Provider.of<UserProvider>(context, listen: false).getUser;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              width: double.maxFinite,
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(userData['photourl']),
                    radius: 80,
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: 60,
                            width: w * 0.95,
                            decoration: BoxDecoration(
                                color: Colors.amber[50],
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 3,
                                      offset: const Offset(5, 5),
                                      color:
                                          Colors.greenAccent.withOpacity(0.5))
                                ]),
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 15.0),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.person,
                                  size: 30,
                                  color: Colors.blue,
                                ),
                                const SizedBox(width: 15),
                                Text(
                                  userData['username'],
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 60,
                            width: w * 0.95,
                            decoration: BoxDecoration(
                                color: Colors.amber[50],
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 3,
                                      offset: const Offset(5, 5),
                                      color:
                                          Colors.greenAccent.withOpacity(0.5))
                                ]),
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 15.0),
                            child: Row(
                              children: [
                                const Icon(
                                  CupertinoIcons.mail_solid,
                                  size: 30,
                                  color: Colors.blue,
                                ),
                                const SizedBox(width: 15),
                                Text(userData['email'],
                                    style: const TextStyle(fontSize: 18)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 60,
                            width: w * 0.95,
                            decoration: BoxDecoration(
                                color: Colors.amber[50],
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 3,
                                      offset: const Offset(5, 5),
                                      color:
                                          Colors.greenAccent.withOpacity(0.5))
                                ]),
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 15.0),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.upload_rounded,
                                  size: 30,
                                  color: Colors.blue,
                                ),
                                const SizedBox(width: 15),
                                Text(
                                  "${user.postCount} Posts",
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 60,
                            width: w * 0.95,
                            decoration: BoxDecoration(
                                color: Colors.amber[50],
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 3,
                                      offset: const Offset(5, 5),
                                      color:
                                          Colors.greenAccent.withOpacity(0.5))
                                ]),
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 15.0),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.message,
                                  size: 30,
                                  color: Colors.blue,
                                ),
                                const SizedBox(width: 15),
                                Text(userData['bio'],
                                    style: const TextStyle(fontSize: 18)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          GestureDetector(
                            onTap: () {
                              AuthController.instance.logout();
                            },
                            child: Container(
                              height: 50,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: Colors.lightGreenAccent,
                                  borderRadius: BorderRadius.circular(8.0),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 5,
                                      offset: const Offset(5, 5),
                                      color: Colors.lightBlue.withOpacity(0.75),
                                    )
                                  ]),
                              child: const Center(
                                  child: Text(
                                "Logout",
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
