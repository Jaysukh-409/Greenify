import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:greenify_new/screens/profilepage.dart';

class TreeSearchPage extends StatefulWidget {
  const TreeSearchPage({Key? key}) : super(key: key);

  @override
  State<TreeSearchPage> createState() => _TreeSearchPageState();
}

class _TreeSearchPageState extends State<TreeSearchPage> {
  final TextEditingController searchcontroller = TextEditingController();
  bool isShowTrees = false;

  @override
  void dispose() {
    super.dispose();
    searchcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: TextFormField(
          controller: searchcontroller,
          decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.search_rounded,
              color: Colors.white,
            ),
            hintText: "Search for a Tree",
            hintStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          onFieldSubmitted: (String _) {
            setState(() {
              isShowTrees = true;
            });
          },
        ),
      ),
      body: isShowTrees
          ? FutureBuilder(
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: (snapshot.data! as dynamic).docs.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(
                              uid: (snapshot.data! as dynamic).docs[index]
                                  ['uid']),
                        ),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            (snapshot.data! as dynamic).docs[index]['photourl'],
                          ),
                        ),
                        title: Text((snapshot.data! as dynamic).docs[index]
                            ['username']),
                      ),
                    );
                  },
                );
              },
              future: FirebaseFirestore.instance
                  .collection('users')
                  .where(
                    'username',
                    isGreaterThanOrEqualTo: searchcontroller.text,
                  )
                  .get(),
            )
          : const Center(child: Text("Search Something")),
    );
  }
}
