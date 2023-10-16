import 'package:reddit_dart/reddit_dart.dart';

Future<void> main() async {
  const redditAppId = '';
  const redditAppSecret = '';

  final RedditClient reddit = RedditClient(redditAppId, redditAppSecret);

  Listing sub = await reddit.getSub('beau_gosse');

  var gallery = sub.children.where((element) =>
      element is Link && element.isGallery != null && element.isGallery!);

  print(gallery.length);
}
