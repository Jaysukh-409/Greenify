import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:greenify_new/providers/user_provider.dart';
import 'package:greenify_new/utilities/firestoremethods.dart';
import 'package:greenify_new/utilities/pickimage.dart';
import 'package:greenify_new/utilities/snackbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:greenify_new/utilities/user.dart' as model;

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  Uint8List? _file;
  final TextEditingController _captioncontroller = TextEditingController();
  bool _isPosting = false;

  void postImage(
    String uid,
    String username,
    String profImage,
  ) async {
    setState(() {
      _isPosting = true;
    });
    try {
      String res = await FirestoreMethods().uploadpost(
        _captioncontroller.text,
        _file!,
        uid,
        username,
        profImage,
      );

      if (res == "Success") {
        setState(() {
          _isPosting = false;
          _file = null;
        });
        showSnackBar("Posted Successfully!!!", res, context);
      } else {
        setState(() {
          _isPosting = false;
        });
        showSnackBar("Not Posted", res, context);
      }
    } catch (e) {
      showSnackBar("Error Occured", e.toString(), context);
    }
  }

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text("Creates Post Using"),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Take a Photo"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Choose from Gallery"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _captioncontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model.User user =
        Provider.of<UserProvider>(context, listen: false).getUser;

    // When Image is not Selected
    return (_file == null)
        ? Center(
            child: IconButton(
              icon: const Icon(Icons.upload_rounded),
              onPressed: () => _selectImage(context),
            ),
          )
        :
        // When Image is Selected
        Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.green,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: clearImage,
              ),
              title: const Text("Post"),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () => postImage(
                    user.uid,
                    user.username,
                    user.photourl,
                  ),
                  icon: const Icon(
                    Icons.send_rounded,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                _isPosting ? const LinearProgressIndicator() : Container(),
                const SizedBox(height: 10),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(user.photourl),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: TextField(
                    controller: _captioncontroller,
                    decoration: const InputDecoration(
                      hintText: "Write Caption",
                      border: InputBorder.none,
                    ),
                    maxLines: 5,
                  ),
                ),
                SizedBox(
                  height: 150,
                  width: 150,
                  child: AspectRatio(
                    aspectRatio: 487 / 451,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: MemoryImage(_file!),
                          fit: BoxFit.fill,
                          alignment: FractionalOffset.topCenter,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
