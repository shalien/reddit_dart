import 'package:meta/meta.dart';

@immutable
abstract class Votable {
  final int? ups;

  final int? downs;

  final bool? likes;

  Votable({this.ups, this.downs, this.likes});

  Votable.fromJson(Map<String, dynamic> json)
      : ups = json['ups'],
        downs = json['downs'],
        likes = json['likes'];
}
