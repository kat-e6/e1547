import 'package:e1547/client.dart';
import 'package:e1547/interface.dart';
import 'package:e1547/post.dart';
import 'package:e1547/settings.dart';
import 'package:flutter/material.dart';

class FavPage extends StatefulWidget {
  const FavPage();

  @override
  _FavPageState createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  bool error = false;
  PostController? controller;

  @override
  void initState() {
    super.initState();
    settings.credentials.value.then((value) {
      if (value != null) {
        setState(() {
          controller = PostController(
            provider: (tags, page) {
              return client.posts(tags, page);
            },
            search: 'fav:${value.username}',
            canDeny: false,
          );
        });
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageLoader(
      builder: (context) => PostsPage(
        appBarBuilder: defaultAppBarBuilder('Favorites'),
        controller: controller!,
      ),
      isBuilt: controller != null,
      isError: error,
      onError: Text('You are not logged in'),
    );
  }
}
