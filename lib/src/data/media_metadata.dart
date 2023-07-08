import 'package:meta/meta.dart';

@immutable
final class MediaMetadata {
  final String? status;
  final String? e;
  final String? m;

  final dynamic o;
  final dynamic p;
  final dynamic s;

  final String? id;

  MediaMetadata._({
    this.status,
    this.e,
    this.m,
    this.o,
    this.p,
    this.s,
    this.id,
  });

  factory MediaMetadata.fromJson(Map<String, dynamic> json) {
    return MediaMetadata._(
      status: json['status'],
      e: json['e'],
      m: json['m'],
      o: json['o'],
      p: json['p'],
      s: json['s'],
      id: json['id'],
    );
  }
}
