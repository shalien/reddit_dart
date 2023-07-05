import 'package:meta/meta.dart';

import 'thing.dart';

@immutable
class Listing {
  final String? before;
  final String? after;
  final String? modhash;
  final int dist;

  final List<Thing> children;

  Listing(
      {this.before,
      this.after,
      this.modhash,
      required this.children,
      this.dist = 0});

  Listing.fromJson(Map<String, dynamic> json)
      : before = json['before'],
        after = json['after'],
        modhash = json['modhash'],
        dist = json['dist'],
        children = (json['children'] as List<dynamic>)
            .map((e) => Thing.resolveThing(e) as Thing)
            .toList();
}
