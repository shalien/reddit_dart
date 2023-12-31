import 'dart:io';

import 'package:reddit_dart/reddit_dart.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    test('Get Beau Gosse Modhash', () async {
      const redditAppId = 'cbJKqzlZ8soXvU_tvP5KWw';
      const redditAppSecret = '0NfZpOoAOScSyDMiEjgh4Uwe0yp5Hw';

      final RedditClient reddit =
          RedditClient(redditAppId, redditAppSecret);

      Listing sub = await reddit.getSub('beau_gosse');

      expect(sub.dist, 9);
    });

    test('Url filtering', () async {
      const redditAppId = 'cbJKqzlZ8soXvU_tvP5KWw';
      const redditAppSecret = '0NfZpOoAOScSyDMiEjgh4Uwe0yp5Hw';

      final RedditClient reddit =
          RedditClient(redditAppId, redditAppSecret);

      Listing sub = await reddit.getSub('https://www.reddit.com/r/beau_gosse');

      expect(sub.dist, 8);
    });

    test('Get by new', () async {
      const redditAppId = 'cbJKqzlZ8soXvU_tvP5KWw';
      const redditAppSecret = '0NfZpOoAOScSyDMiEjgh4Uwe0yp5Hw';

      final RedditClient reddit =
          RedditClient(redditAppId, redditAppSecret);

      Listing sub = await reddit.getSubByNew('beau_gosse');

      expect(sub.dist, 7);
    });

    test('Select where is gallery', () async {
      const redditAppId = 'cbJKqzlZ8soXvU_tvP5KWw';
      const redditAppSecret = '0NfZpOoAOScSyDMiEjgh4Uwe0yp5Hw';

      final RedditClient reddit =
          RedditClient(redditAppId, redditAppSecret);

      Listing sub = await reddit.getSub('beau_gosse');

      var gallery = sub.children.where((element) =>
          element is Link && element.isGallery != null && element.isGallery!);

      expect(gallery.length, 1);
    });

    test('Download image', () async {
      const redditAppId = 'cbJKqzlZ8soXvU_tvP5KWw';
      const redditAppSecret = '0NfZpOoAOScSyDMiEjgh4Uwe0yp5Hw';

      final RedditClient reddit =
          RedditClient(redditAppId, redditAppSecret);

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
      const redditAppId = 'cbJKqzlZ8soXvU_tvP5KWw';
      const redditAppSecret = '0NfZpOoAOScSyDMiEjgh4Uwe0yp5Hw';

      final RedditClient reddit =
          RedditClient(redditAppId, redditAppSecret);

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

    test('Url parsing', () {
      // Ending / is important !!
      var test = 'https://reddit.com/r/beau_gosse/';

      const redditAppId = 'cbJKqzlZ8soXvU_tvP5KWw';
      const redditAppSecret = '0NfZpOoAOScSyDMiEjgh4Uwe0yp5Hw';

      final RedditClient reddit =
          RedditClient(redditAppId, redditAppSecret);

      var parsed = reddit.parseInput(test);

      expect(parsed, 'beau_gosse');
    });

    test('Image finding', () async {
      var testSub = 'https://www.reddit.com/user/xxN1ROMxx/';

      const redditAppId = 'cbJKqzlZ8soXvU_tvP5KWw';
      const redditAppSecret = '0NfZpOoAOScSyDMiEjgh4Uwe0yp5Hw';

      final RedditClient reddit =
          RedditClient(redditAppId, redditAppSecret);

      Listing sub = await reddit.get(testSub);

      List<Link> images = sub.children
          .where((element) => element is Link && element.linkIsImage)
          .map((e) => e as Link)
          .toList();

      print(images.length);

      expect(images.length, greaterThan(0));
    });

    test('Video finding', () async {
      var testSub = 'https://www.reddit.com/r/asiangirlsblackcocks';

      const redditAppId = 'cbJKqzlZ8soXvU_tvP5KWw';
      const redditAppSecret = '0NfZpOoAOScSyDMiEjgh4Uwe0yp5Hw';

      final RedditClient reddit =
          RedditClient(redditAppId, redditAppSecret);

      Listing sub = await reddit.get(testSub);

      List<Link> images = sub.children
          .where((element) => element is Link && element.linkIsVideo)
          .map((e) => e as Link)
          .toList();

      print(images.length);

      expect(images.length, greaterThan(0));
    });
  });
}
