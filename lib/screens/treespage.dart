import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:greenify_new/utilities/trees.dart';
import 'package:greenify_new/widgets/treewidget.dart';

class TreesPage extends StatefulWidget {
  const TreesPage({Key? key}) : super(key: key);

  @override
  _TreesPageState createState() => _TreesPageState();
}

class _TreesPageState extends State<TreesPage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    final treejson = await rootBundle.loadString("resource/files/tree.json");
    final decodeData = jsonDecode(treejson);
    var treedata = decodeData["tree"];
    TreeModel.tree =
        List.from(treedata).map<Tree>((tree) => Tree.fromJson(tree)).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: const Text("Trees"),
      ),
      body: Card(
        child: ListView.builder(
          itemCount: TreeModel.tree.length,
          itemBuilder: (context, index) {
            return TreeWidget(
              tree: TreeModel.tree[index],
            );
          },
        ),
      ),
    );
  }
}
