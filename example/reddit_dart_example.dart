import 'package:reddit_dart/reddit_dart.dart';

Future<void> main() async {
  const REDDIT_APP_ID = '';
  const REDDIT_APP_SECRET = '';

  final RedditClient reddit = RedditClient(REDDIT_APP_ID, REDDIT_APP_SECRET);

  Listing sub = await reddit.getSub('beau_gosse');

  var gallery = sub.children.where((element) =>
      element is Link && element.isGallery != null && element.isGallery!);

  print(gallery.length);
}
