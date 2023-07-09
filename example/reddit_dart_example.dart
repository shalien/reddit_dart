import 'package:reddit_dart/reddit_dart.dart';

Future<void> main() async {
  final RedditClient reddit = RedditClient();

  Listing sub = await reddit.getSub('beau_gosse');

  var gallery = sub.children.where((element) =>
      element is Link && element.isGallery != null && element.isGallery!);

  print(gallery.length);
}
