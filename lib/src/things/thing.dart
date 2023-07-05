import 'package:meta/meta.dart';
import 'package:reddit_dart/src/data/subreddit.dart';

import '../data/comment.dart';
import '../data/link.dart';
import 'listing.dart';

@immutable
abstract class Thing {
  final String? id;

  final String? name;

  final String? kind;

  Thing({this.id, this.name, this.kind});

  Thing.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        kind = json['kind'];

  static dynamic resolveThing(Map<String, dynamic> json) {
    var kind = json['kind'];
    var data = json['data'];

    switch (kind) {
      case 't1':
        return Comment.fromJson(data);
      case 't2':
        break;
      case 't3':
        return Link.fromJson(data);
      case 't4':
        break;
      case 't5':
        return Subreddit.fromJson(data);
      case 't6':
        break;
      case 'Listing':
        return Listing.fromJson(data);
      case 'more':
        break;
      default:
        throw Exception('Unknown kind: $kind');
    }
  }
}
