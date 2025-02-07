import 'package:e1547/post.dart';
import 'package:e1547/tag.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'rating.dart';

class FileDisplay extends StatelessWidget {
  final Post post;
  final PostController? controller;
  final DateFormat dateFormat = DateFormat('dd.MM.yy HH:mm');

  FileDisplay({required this.post, this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          child: Text(
            'File',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TagGesture(
                child: Text(ratingTexts[post.rating]!),
                tag: 'rating:${ratingValues.reverse![post.rating]}',
                controller: controller,
              ),
              Text('${post.file.width} x ${post.file.height}'),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(dateFormat.format(post.createdAt.toLocal())),
              Text(filesize(post.file.size, 1)),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (post.updatedAt != null)
                Text(dateFormat.format(post.updatedAt!.toLocal())),
              TagGesture(
                child: Text(post.file.ext),
                tag: 'type:${post.file.ext}',
                controller: controller,
              ),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
