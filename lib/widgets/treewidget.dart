import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greenify_new/widgets/treedetail.dart';
import 'package:greenify_new/utilities/trees.dart';

class TreeWidget extends StatelessWidget {
  const TreeWidget({Key? key, required this.tree}) : super(key: key);

  final Tree tree;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Get.offAll(() => TreeDetail(
              name: tree.name,
              description: tree.description,
              soil: tree.soil,
            ))
      },
      child: Card(
        child: ListTile(
          leading: Text(
            tree.id.toString(),
            textScaleFactor: 2.0,
            style: const TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
          title: Text(
            tree.name,
            textScaleFactor: 1.5,
            style: const TextStyle(
              color: Colors.deepPurpleAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
