import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart';

import 'things/listing.dart';

class RedditClient {
  static RedditClient? _instance;

  final Client client;

  RedditClient._(this.client);

  factory RedditClient({Client? client}) =>
      _instance ??= RedditClient._(client ?? Client());

  Future<Listing> getSub(String sub,
      {Map<String, String> options = const {}}) async {
    Uri uri = Uri.https('www.reddit.com', '/r/${_parseInput(sub)}.json');

    if (options.isNotEmpty) {
      uri = uri.replace(queryParameters: options);
    }

    var response = await client.get(uri);

    if (response.statusCode == 200) {
      var decoded = jsonDecode(response.body);

      if (decoded['error'] != null) {
        throw Exception(decoded['error']);
      }

      if (decoded['kind'] != 'Listing') {
        throw Exception('Not a listing');
      }

      return Listing.fromJson(decoded['data']);
    } else {
      throw Exception(response);
    }
  }

  Future<Listing> getSubByBest(String sub,
      {Map<String, dynamic> options = const {}}) async {
    Uri uri = Uri.https('www.reddit.com', '/r/${_parseInput(sub)}/best.json');

    if (options.isNotEmpty) {
      uri = uri.replace(queryParameters: options);
    }

    var response = await client.get(uri);

    if (response.statusCode == 200) {
      var decoded = jsonDecode(response.body);

      if (decoded['error'] != null) {
        throw Exception(decoded['error']);
      }

      if (decoded['kind'] != 'Listing') {
        throw Exception('Not a listing');
      }

      return Listing.fromJson(decoded['data']);
    } else {
      throw Exception(response);
    }
  }

  Future<Listing> getSubByHot(String sub,
      {Map<String, dynamic> options = const {}}) async {
    Uri uri = Uri.https('www.reddit.com', '/r/${_parseInput(sub)}/hot.json');

    if (options.isNotEmpty) {
      uri = uri.replace(queryParameters: options);
    }

    var response = await client.get(uri);

    if (response.statusCode == 200) {
      var decoded = jsonDecode(response.body);

      if (decoded['error'] != null) {
        throw Exception(decoded['error']);
      }

      if (decoded['kind'] != 'Listing') {
        throw Exception('Not a listing');
      }

      return Listing.fromJson(decoded['data']);
    } else {
      throw Exception(response);
    }
  }

  Future<Listing> getSubByNew(String sub,
      {Map<String, dynamic> options = const {}}) async {
    Uri uri = Uri.https('www.reddit.com', '/r/${_parseInput(sub)}/new.json');

    if (options.isNotEmpty) {
      uri = uri.replace(queryParameters: options);
    }

    var response = await client.get(uri);

    if (response.statusCode == 200) {
      var decoded = jsonDecode(response.body);

      if (decoded['error'] != null) {
        throw Exception(decoded['error']);
      }

      if (decoded['kind'] != 'Listing') {
        throw Exception('Not a listing');
      }

      return Listing.fromJson(decoded['data']);
    } else {
      throw Exception(response);
    }
  }

  Future<Listing> getSubByRising(String sub,
      {Map<String, dynamic> options = const {}}) async {
    Uri uri = Uri.https('www.reddit.com', '/r/${_parseInput(sub)}/rising.json');

    if (options.isNotEmpty) {
      uri = uri.replace(queryParameters: options);
    }

    var response = await client.get(uri);

    if (response.statusCode == 200) {
      var decoded = jsonDecode(response.body);

      if (decoded['error'] != null) {
        throw Exception(decoded['error']);
      }

      if (decoded['kind'] != 'Listing') {
        throw Exception('Not a listing');
      }

      return Listing.fromJson(decoded['data']);
    } else {
      throw Exception(response);
    }
  }

  Future<Uint8List> downloadImage(String url) async {
    var response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception(response);
    }
  }

  Future<Uint8List> downloadVideo(String url) async {
    const List<int> sizes = [360, 480, 720, 1080];

    for (var size in sizes) {
      var response = await client.get(Uri.parse('$url/DASH_$size.mp4'));

      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else if (response.statusCode == 404 || response.statusCode == 403) {
        continue;
      } else {
        throw Exception(response);
      }
    }

    throw Exception('No video found');
  }

  String _parseInput(String input) {
    if (input.startsWith('https://reddit.com/r/') ||
        input.startsWith(('https://www.reddit.com/r/'))) {
      return input
          .replaceAll('https://reddit.com/r/', '')
          .replaceAll('https://www.reddit.com/r/', '');
    } else {
      return input;
    }
  }
}
