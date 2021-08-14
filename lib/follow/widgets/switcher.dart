import 'package:e1547/follow.dart';
import 'package:e1547/interface.dart';
import 'package:e1547/settings.dart';
import 'package:flutter/material.dart';

class FollowsPage extends StatefulWidget {
  @override
  _FollowsPageState createState() => _FollowsPageState();
}

class _FollowsPageState extends State<FollowsPage> with LinkingMixin {
  bool? isSplit;

  Future<void> update() async {
    await settings.followsSplit.value
        .then((value) => setState(() => isSplit = value));
  }

  @override
  Map<ChangeNotifier, VoidCallback> get links => {
        settings.followsSplit: update,
      };

  @override
  Widget build(BuildContext context) {
    return PageLoader(
        builder: (context) => AnimatedSwitcher(
              duration: defaultAnimationDuration,
              child: isSplit == null
                  ? SizedBox.shrink()
                  : isSplit!
                      ? FollowsSplitPage()
                      : FollowsCombinedPage(),
            ),
        isLoading: isSplit == null,
        isEmpty: false,
        isError: false);
  }
}
