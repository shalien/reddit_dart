import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:http/http.dart';

import 'things/listing.dart';

class RedditClient {
  static RedditClient? _instance;

  final Client _client;

  String? _token;
  DateTime? _refreshToken;

  Future<String> get token async {
    if (_token == null ||
        (_refreshToken == null || DateTime.now().isAfter(_refreshToken!))) {
      await getOauthToken();
    }

    return _token!;
  }

  final String appId;

  final String appSecret;

  int rateLimitRemaining = 0;
  int rateLimitReset = 0;
  int rateLimitUsed = 0;

  RedditClient._(this.appId, this.appSecret, {client})
      : _client = client ?? Client();

  factory RedditClient(String appId, String appSecret, {Client? client}) =>
      _instance ??= RedditClient._(appId, appSecret, client: client);

  Future<Listing> get(String url, {Map<String, String> options = const {}}) {
    if (url.contains('user')) {
      return getUser(url, options: options);
    } else if (url.contains('r')) {
      return getSub(url, options: options);
    } else {
      throw Exception('Not a valid url');
    }
  }

  Future<Listing> getUser(String user,
      {Map<String, String> options = const {}}) async {
    Uri uri = Uri.https('oauth.reddit.com', '/user/${_parseInput(user)}');

    if (options.isNotEmpty) {
      uri = uri.replace(queryParameters: options);
    }

    var response = await _checkRateLimit(
        _client.get(uri, headers: {'Authorization': 'bearer ${await token}'}));

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
      throw response;
    }
  }

  Future<void> getOauthToken() async {
    String basic = base64Encode(utf8.encode('$appId:$appSecret'));

    Uri uri = Uri.https('www.reddit.com', '/api/v1/access_token');

    var response = await _client.post(uri, body: {
      'grant_type': 'client_credentials',
      'deivce_id': 'DO_NOT_TRACK_THIS_DEVICE'
    }, headers: {
      'Authorization': 'Basic $basic'
    });

    if (response.statusCode == 200) {
      var decoded = jsonDecode(response.body);

      _token = decoded['access_token'];
      _refreshToken =
          DateTime.now().add(Duration(seconds: decoded['expires_in']));
    } else {
      throw response;
    }
  }

  Future<Listing> getSub(String sub,
      {Map<String, String> options = const {}}) async {
    Uri uri = Uri.https('oauth.reddit.com', '/r/${_parseInput(sub)}.json');

    if (options.isNotEmpty) {
      uri = uri.replace(queryParameters: options);
    }

    var response = await _checkRateLimit(
        _client.get(uri, headers: {'Authorization': 'bearer ${await token}'}));

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
      throw response;
    }
  }

  Future<Listing> getSubByBest(String sub,
      {Map<String, dynamic> options = const {}}) async {
    Uri uri = Uri.https('oauth.reddit.com', '/r/${_parseInput(sub)}/best');

    if (options.isNotEmpty) {
      uri = uri.replace(queryParameters: options);
    }

    var response = await _checkRateLimit(
        _client.get(uri, headers: {'Authorization': 'bearer ${await token}'}));

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
      throw response;
    }
  }

  Future<Listing> getSubByHot(String sub,
      {Map<String, dynamic> options = const {}}) async {
    Uri uri = Uri.https('oauth.reddit.com', '/r/${_parseInput(sub)}/hot.json');

    if (options.isNotEmpty) {
      uri = uri.replace(queryParameters: options);
    }

    var response = await _checkRateLimit(
        _client.get(uri, headers: {'Authorization': 'bearer ${await token}'}));

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
      throw response;
    }
  }

  Future<Listing> getSubByNew(String sub,
      {Map<String, dynamic> options = const {}}) async {
    Uri uri = Uri.https('oauth.reddit.com', '/r/${_parseInput(sub)}/new.json');

    if (options.isNotEmpty) {
      uri = uri.replace(queryParameters: options);
    }

    var response = await _checkRateLimit(
        _client.get(uri, headers: {'Authorization': 'bearer ${await token}'}));

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
      throw response;
    }
  }

  Future<Listing> getSubByRising(String sub,
      {Map<String, dynamic> options = const {}}) async {
    Uri uri =
        Uri.https('oauth.reddit.com', '/r/${_parseInput(sub)}/rising.json');

    if (options.isNotEmpty) {
      uri = uri.replace(queryParameters: options);
    }

    var response = await _checkRateLimit(
        _client.get(uri, headers: {'Authorization': 'bearer ${await token}'}));

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
      throw response;
    }
  }

  Future<Uint8List> downloadImage(String url) async {
    var response = await _checkRateLimit(_client.get(Uri.parse(url),
        headers: {'Authorization': 'bearer ${await token}'}));

    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw response;
    }
  }

  Future<Uint8List> downloadVideo(String url) async {
    const List<int> sizes = [360, 480, 720, 1080];

    for (var size in sizes) {
      var response = await _checkRateLimit(_client.get(
          Uri.parse('$url/DASH_$size.mp4'),
          headers: {'Authorization': 'bearer ${await token}'}));

      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else if (response.statusCode == 404 || response.statusCode == 403) {
        continue;
      } else {
        throw response;
      }
    }

    throw Exception('No video found');
  }

  String parseInput(String input) => _parseInput(input);

  String _parseInput(String input) {
    if (Uri.tryParse(input) != null) {
      var uri = Uri.parse(input);

      if (!uri.host.contains('reddit')) {
        return input;
      }

      if (uri.pathSegments.isNotEmpty) {
        if (uri.pathSegments.first == 'r' && uri.pathSegments.length > 1) {
          return uri.pathSegments[1];
        } else if (uri.pathSegments.first == 'user' &&
            uri.pathSegments.length > 1) {
          return uri.pathSegments[1];
        } else {
          throw Exception('Not a subreddit');
        }
      } else {
        return input;
      }
    } else {
      return input;
    }
  }

  void updateRateLimit(Response response) {
    if (response.headers['x-ratelimit-remaining'] != null) {
      rateLimitRemaining =
          int.parse(response.headers['x-ratelimit-remaining']!);
    }

    if (response.headers['x-ratelimit-reset'] != null) {
      rateLimitReset = int.parse(response.headers['x-ratelimit-reset']!);
    }

    if (response.headers['x-ratelimit-used'] != null) {
      rateLimitUsed = int.parse(response.headers['x-ratelimit-used']!);
    }
  }

  Future<Response> _checkRateLimit(Future<Response> callback) async {
    return Future.delayed(
        Duration(seconds: rateLimitReset + Random.secure().nextInt(10)),
        () => callback);
  }
}
