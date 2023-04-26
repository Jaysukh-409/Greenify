// ignore_for_file: avoid_unnecessary_containers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenify_new/screens/addpostpage.dart';
import 'package:greenify_new/screens/feedscreen.dart';
import 'package:greenify_new/screens/homepage.dart';
import 'package:greenify_new/screens/leaderboard.dart';
import 'package:greenify_new/screens/profilepage.dart';
import 'package:greenify_new/screens/tree_search_page.dart';
// import 'package:greenify_new/screens/tree_search_page.dart';
import 'package:greenify_new/screens/treespage.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _index = 0;

  late PageController pagecontroller;

  @override
  void initState() {
    super.initState();
    addData();
    pagecontroller = PageController();
    setState(() {});
  }

  addData() async {
    UserProvider _userprovider =
        Provider.of<UserProvider>(context, listen: false);
    await _userprovider.refreshUser();
  }

  @override
  void dispose() {
    super.dispose();
    pagecontroller.dispose();
  }

  void onTapNav(int index) {
    pagecontroller.jumpToPage(index);
  }

  void onPageChanged(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          const FeedScreen(),
          const HomePage(),
          const AddPost(),
          const TreesPage(),
          ProfilePage(
            uid: FirebaseAuth.instance.currentUser!.uid,
          ),
        ],
        controller: pagecontroller,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTapNav,
        currentIndex: _index,
        selectedItemColor: const Color.fromARGB(255, 0, 0, 255),
        unselectedItemColor: Colors.blueGrey,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        items: const [
          BottomNavigationBarItem(
              label: "Home", icon: Icon(CupertinoIcons.house_fill)),
          BottomNavigationBarItem(
              label: "Quotes", icon: Icon(CupertinoIcons.quote_bubble_fill)),
          BottomNavigationBarItem(
              label: "Create", icon: Icon(Icons.add_a_photo_rounded)),
          BottomNavigationBarItem(
              label: "Trees", icon: Icon(CupertinoIcons.tree)),
          BottomNavigationBarItem(
              label: "Profile", icon: Icon(CupertinoIcons.person_alt)),
        ],
      ),
    );
  }
}
