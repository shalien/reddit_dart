import 'package:meta/meta.dart';

@immutable
abstract class Created {
  final double? created;

  final double? createdUtc;

  Created({this.created, this.createdUtc});

  Created.fromJson(Map<String, dynamic> json)
      : created = json['created'],
        createdUtc = json['created_utc'];
}
