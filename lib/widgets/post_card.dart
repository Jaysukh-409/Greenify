import 'package:flutter/material.dart';
import 'package:greenify_new/providers/user_provider.dart';
import 'package:greenify_new/utilities/firestoremethods.dart';
import 'package:greenify_new/utilities/user.dart' as model;
import 'package:greenify_new/widgets/like_animation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;

  @override
  Widget build(BuildContext context) {
    final model.User user =
        Provider.of<UserProvider>(context, listen: false).getUser;
    return Container(
      color: const Color.fromARGB(255, 173, 243, 255),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16,
            ).copyWith(right: 8),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.snap['profImage']),
                  radius: 16,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.snap['username'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                widget.snap['isVerified']
                    ? const Icon(Icons.verified_rounded)
                    : const Icon(
                        Icons.verified_outlined,
                        color: Colors.transparent,
                      ),
              ],
            ),
          ),
          // Image Section
          GestureDetector(
            onDoubleTap: () async {
              await FirestoreMethods().likePost(
                widget.snap['postid'],
                user.uid,
                widget.snap['likes'],
              );
              setState(() {
                isLikeAnimating = true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: double.infinity,
                  child: Image.network(
                    widget.snap['postUrl'],
                    fit: BoxFit.cover,
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isLikeAnimating ? 1 : 0,
                  child: widget.snap['likes'].contains(user.uid)
                      ? LikeAnimation(
                          child: const Icon(
                            Icons.favorite_rounded,
                            color: Colors.red,
                            size: 100,
                          ),
                          isAnimating: isLikeAnimating,
                          duration: const Duration(milliseconds: 400),
                          onEnd: () {
                            setState(
                              () {
                                isLikeAnimating = false;
                              },
                            );
                          },
                        )
                      : LikeAnimation(
                          child: const Icon(
                            Icons.favorite_border_rounded,
                            color: Colors.white,
                            size: 100,
                          ),
                          isAnimating: isLikeAnimating,
                          duration: const Duration(milliseconds: 400),
                          onEnd: () {
                            setState(
                              () {
                                isLikeAnimating = false;
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
          // Like Section
          Container(
            padding: const EdgeInsets.only(
              right: 12,
            ),
            child: Row(
              children: [
                LikeAnimation(
                  isAnimating: widget.snap['likes'].contains(user.uid),
                  smalllike: true,
                  child: IconButton(
                    onPressed: () async {
                      await FirestoreMethods().likePost(
                        widget.snap['postid'],
                        user.uid,
                        widget.snap['likes'],
                      );
                    },
                    icon: widget.snap['likes'].contains(user.uid)
                        ? const Icon(
                            Icons.favorite_rounded,
                            color: Colors.red,
                          )
                        : const Icon(
                            Icons.favorite_border_rounded,
                          ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "${widget.snap['likes'].length} Likes",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(DateFormat.yMMMd().format(
                  widget.snap['datePublished'].toDate(),
                ))
              ],
            ),
          ),
          // Description
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 8,
              left: 16,
              right: 16,
            ),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: widget.snap['description'],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 0.5,
            child: Container(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
