import 'dart:io';

import 'package:reddit_dart/reddit_dart.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    test('Get Beau Gosse Modhash', () async {
      final RedditClient reddit = RedditClient();

      Listing sub = await reddit.getSub('beau_gosse');

      expect(sub.dist, 8);
    });

    test('Url filtering', () async {
      final RedditClient reddit = RedditClient();

      Listing sub = await reddit.getSub('https://www.reddit.com/r/beau_gosse');

      expect(sub.dist, 8);
    });

    test('Get by new', () async {
      final RedditClient reddit = RedditClient();

      Listing sub = await reddit.getSubByNew('beau_gosse');

      expect(sub.dist, 7);
    });

    test('Select where is gallery', () async {
      final RedditClient reddit = RedditClient();

      Listing sub = await reddit.getSub('beau_gosse');

      var gallery = sub.children.where((element) =>
          element is Link && element.isGallery != null && element.isGallery!);

      expect(gallery.length, 1);
    });

    test('Download image', () async {
      final RedditClient reddit = RedditClient();

      Listing sub = await reddit.getSub('test_bg');

      Link? image = sub.children
          .where((element) => element is Link && element.linkIsImage)
          .firstOrNull as Link?;

      if (image == null) {
        throw Exception('No image found');
      }

      var url = image.url;

      var body = await reddit.downloadImage(url);

      print(body.length);

      File file = File('test.${image.url.split('/').last.split('.').last}');

      await file.writeAsBytes(body);
    });

    test('Download video', () async {
      final RedditClient reddit = RedditClient();

      Listing sub = await reddit.getSub('test_bg');

      Link? video = sub.children
          .where((element) => element is Link && element.linkIsVideo)
          .firstOrNull as Link?;

      if (video == null) {
        throw Exception('No video found');
      }

      var url = video.url;

      var body = await reddit.downloadVideo(url);

      print(body.length);

      File file = File('test.mp4');

      await file.writeAsBytes(body);

      expect(body, isNotNull);
    });
  });
}
