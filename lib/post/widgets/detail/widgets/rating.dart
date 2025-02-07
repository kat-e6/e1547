import 'package:e1547/post.dart';
import 'package:flutter/material.dart';

Map<Rating, IconData> ratingIcons = {
  Rating.S: Icons.check_circle_outline,
  Rating.Q: Icons.help_outline,
  Rating.E: Icons.warning,
};

Map<Rating, String> ratingTexts = {
  Rating.S: 'Safe',
  Rating.Q: 'Questionable',
  Rating.E: 'Explicit',
};

class RatingDisplay extends StatelessWidget {
  final Post post;

  RatingDisplay({required this.post});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: post,
      builder: (context, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                right: 4,
                left: 4,
                top: 2,
                bottom: 2,
              ),
              child: Text(
                'Rating',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            ListTile(
              title: Text(ratingTexts[post.rating]!),
              leading: Icon(!post.flags.ratingLocked
                  ? ratingIcons[post.rating]
                  : Icons.lock),
              onTap: !post.flags.ratingLocked
                  ? () => showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return RatingDialog(onTap: (rating) {
                            post.rating = rating;
                            post.notifyListeners();
                          });
                        },
                      )
                  : null,
            ),
            Divider(),
          ],
        );
      },
    );
  }
}

class RatingDialog extends StatelessWidget {
  final Function(Rating rating) onTap;

  RatingDialog({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Rating'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: ratingTexts.entries
            .map(
              (entry) => ListTile(
                title: Text(entry.value),
                leading: Icon(ratingIcons[entry.key]),
                onTap: () {
                  onTap(entry.key);
                  Navigator.of(context).pop();
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
